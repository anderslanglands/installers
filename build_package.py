#! /usr/bin/env python3

"""
Usage:
    build_package.py [-rv] [-j=<nc>] <name> <version>...

Options:
    -v --verbose            Print more debug info
    -r --redownload-files   If existing files are found on disk, delete them and
                            redownload. The default behaviour is to use the existing
                            files.
    -j --num-cores=<nc>     Number of cores to use for building. Defaults to
                            the number of physical cores found if not specified

"""
from docopt import docopt

import imp
import logging
import os
import sys
import pathlib
import subprocess
import shutil
from glob import glob
import urllib.request
import multiprocessing
from semantic_version import Version, SimpleSpec


class CustomFormatter(logging.Formatter):
    """Logging Formatter to add colors and count warning / errors"""

    grey = "\x1b[38;21m"
    green = "\x1b[32;21m"
    yellow = "\x1b[33;21m"
    red = "\x1b[31;21m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"
    fmt = "%(asctime)s (%(filename)s:%(lineno)d) [%(levelname)s] %(message)s "

    FORMATS = {
        logging.DEBUG: grey + fmt + reset,
        logging.INFO: green + fmt + reset,
        logging.WARNING: yellow + fmt + reset,
        logging.ERROR: red + fmt + reset,
        logging.CRITICAL: bold_red + fmt + reset
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


log = logging.getLogger('build_package')
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
ch.setFormatter(CustomFormatter())
log.addHandler(ch)

SCRIPT_DIR = pathlib.Path(__file__).parent.absolute()
PKG_ROOT = os.getenv('PKG_ROOT') or os.path.join(os.getenv('HOME'), 'packages')
PKG_BUILD_ROOT = os.getenv('PKG_BUILD_ROOT') or os.path.join(
    os.getenv('HOME'), 'pkgbuild')
PKG_RECIPE_ROOT = os.getenv(
    'PKG_RECIPE_ROOT') or os.path.join(SCRIPT_DIR, 'recipes')

OPT_REDOWNLOAD_FILES = False
NUM_CORES = multiprocessing.cpu_count()


def print_header(text: str):
    columns, _ = os.get_terminal_size(0)
    line = '-' * columns
    margin = int((columns - len(text)) / 2)
    print(line)
    print(str(' ' * margin) + text)
    print(line)


def expand_vars(text: str, pkg_install_dir: str, opt_num_cores: int):
    text = text.replace('%PKG_INSTALL_DIR%', pkg_install_dir)
    text = text.replace('%OPT_NUM_CORES%', str(opt_num_cores))
    return text


class PackageDownloadException(Exception):
    pass


class GitSourceDownloadException(PackageDownloadException):
    pass


class SourceBase:
    def __init__(self):
        pass

    def _run_build_commands(self, pkg_build_dir: str, pkg_install_dir: str, build_cmd: list):
        if build_cmd:
            for cmd in build_cmd:
                cmd = expand_vars(cmd, pkg_install_dir, OPT_NUM_CORES)

                try:
                    log.info('>>> ' + cmd)
                    subprocess.run(cmd, cwd=pkg_build_dir, shell=True, check=True)
                except Exception as e:
                    log.error(
                        f'Build command "{cmd}" failed: ' + str(e))
                    return


class GitSource(SourceBase):
    def __init__(self, repo: str, branch: str, commit: str):
        self.repo = repo
        self.branch = branch
        self.commit = commit

    def download_to(self, pkg_build_dir: str):
        try:
            args = ['git', 'clone', '--recurse-submodules']
            if self.branch is not None:
                args.extend(['--branch', self.branch])

            # if we didnt' specify a particular commit, then just get a single revision
            if self.commit is None:
                args.extend(['--depth', '1'])

            args.extend([self.repo, pkg_build_dir])

            if self.branch is None and self.commit is None:
                log.warning(
                    'No branch or commit defined, falling back to HEAD of default')

            log.info('>>>> ' + ' '.join(args))
            subprocess.run(args, check=True)

            if self.commit is not None:
                args = ['git', 'reset', '--hard', self.commit]
                log.info('>>>> ' + ' '.join(args))
                subprocess.run(args, cwd=pkg_build_dir, check=True)

        except Exception as e:
            raise GitSourceDownloadException(
                f'Could not clone branch {self.branch} from {self.repo} into {pkg_build_dir}') from e

    def build(self, pkg_build_dir: str, pkg_install_dir: str, build_cmd: list):
        self._run_build_commands(pkg_build_dir, pkg_install_dir, build_cmd)


class TarSource(SourceBase):
    def __init__(self, url: str):
        self.url = url
        self.filename = os.path.basename(self.url)

    def download_to(self, pkg_build_dir: str):
        pkg_build_root = os.path.dirname(pkg_build_dir)
        pkg_build_tail = os.path.basename(pkg_build_dir)
        tar_file = os.path.join(pkg_build_root, self.filename)
        subprocess.run(['wget', self.url], cwd=pkg_build_root)

        os.makedirs(pkg_build_dir, exist_ok=True)
        log.info('Unpacking... ')
        args = ['tar', 'xf', self.filename, '-C',
                pkg_build_tail, '--strip-components', '1']
        subprocess.run(args, cwd=pkg_build_root)
        log.info('done.')
        os.remove(tar_file)

    def build(self, pkg_build_dir: str, pkg_install_dir: str, build_cmd: list):
        self._run_build_commands(pkg_build_dir, pkg_install_dir, build_cmd)


class BinTarSource(SourceBase):
    def __init__(self, url: str):
        self.url = url
        self.filename = os.path.basename(self.url)

    def download_to(self, pkg_build_dir: str):
        pkg_build_root = os.path.dirname(pkg_build_dir)
        pkg_build_tail = os.path.basename(pkg_build_dir)
        tar_file = os.path.join(pkg_build_root, self.filename)
        subprocess.run(['wget', self.url], cwd=pkg_build_root)

        os.makedirs(pkg_build_dir, exist_ok=True)
        log.info('Unpacking... ')
        args = ['tar', 'xf', self.filename, '-C',
                pkg_build_tail, '--strip-components', '1']
        subprocess.run(args, cwd=pkg_build_root)
        log.info('done.')
        os.remove(tar_file)

    def build(self, pkg_build_dir: str, pkg_install_dir: str, build_cmd: list):
        self._run_build_commands(pkg_build_dir, pkg_install_dir, build_cmd)
        shutil.rmtree(pkg_install_dir)
        shutil.copytree(pkg_build_dir, pkg_install_dir)


class RunfileSource(SourceBase):
    def __init__(self, url: str):
        self.url = url
        self.filename = os.path.basename(self.url)

    def download_to(self, pkg_build_dir: str):
        # download the file to the source directory so we can run it using the
        # build commands
        os.makedirs(pkg_build_dir, exist_ok=True)
        runfile = os.path.join(pkg_build_dir, self.filename)
        if not os.path.isfile(runfile) or OPT_REDOWNLOAD_FILES:
            subprocess.run(['wget', self.url], cwd=pkg_build_dir, check=True)
        else:
            log.debug(
                f'Runfile "{runfile}" exists. Skipping download. Run with "--redownload-files" to override this behaviour')

    def build(self, pkg_build_dir: str, pkg_install_dir: str, build_cmd: list):
        self._run_build_commands(pkg_build_dir, pkg_install_dir, build_cmd)


class CustomSource(SourceBase):
    def __init__(self, cmds: list):
        self.cmds = cmds

    def download_to(self, pkg_build_dir: str):
        os.makedirs(pkg_build_dir, exist_ok=True)

    def build(self, pkg_build_dir: str, pkg_install_dir: str, build_cmd: list):
        self._run_build_commands(pkg_build_dir, pkg_install_dir, self.cmds)


def build_package(name: str, version: str, package_src, build_cmd: list, package_filename: str):
    pkg_build_dir = os.path.join(PKG_BUILD_ROOT, f"{name}-{version}")
    pkg_install_dir = os.path.join(PKG_ROOT, name, version)

    # blow away the build directory
    if os.path.isdir(pkg_build_dir):
        shutil.rmtree(pkg_build_dir)

    try:
        package_src.download_to(pkg_build_dir)
    except Exception as e:
        log.error(f'Error downloading package {name}: {str(e)}')
        return

    # write the rez package description to our local build dir
    shutil.copyfile(package_filename, os.path.join(
        pkg_build_dir, 'package.py'))

    # copy over any patches to the build dir and apply them
    patch_files = glob(os.path.join(
        os.path.dirname(package_filename), '*.patch'))
    for patch in patch_files:
        basename = os.path.basename(patch)
        shutil.copyfile(patch, os.path.join(pkg_build_dir, basename))
        # f = open(patch)
        # subprocess.run(['patch', '-p0'],
        #                cwd=pkg_build_dir, stdin=f, check=True)
        cmd = f'git apply {basename}'
        log.info('>>>> ' + cmd)
        subprocess.run(cmd, shell=True, cwd=pkg_build_dir, check=True)

    # Do the build
    package_src.build(pkg_build_dir, pkg_install_dir, build_cmd)


def get_source_from_package(package_py):
    '''
    Inspect the package's package.py for the 'source' dict and interpret
    its fields to figure out where we're going to get the package from
    '''
    try:
        source_dict = package_py.source
    except AttributeError as e:
        log.error(e)
        return None

    if 'repo' in source_dict.keys():
        # git repo
        repo = source_dict['repo']
        branch = source_dict.get('branch')
        commit = source_dict.get('commit')

        if branch is None and commit is None:
            log.warning(f'Package "{package_py.name}" sources from "{repo}" but does not define a commit or a branch')

        return GitSource(repo, branch, commit)
    elif 'tar' in source_dict.keys():
        # source tarball
        return TarSource(source_dict['tar'])
    elif 'bintar' in source_dict.keys():
        # binary tarball
        return BinTarSource(source_dict['bintar'])
    elif 'runfile' in source_dict.keys():
        # shell script runfile installer
        return RunfileSource(source_dict['runfile'])
    elif 'custom' in source_dict.keys():
        return CustomSource(source_dict['custom'])
    else:
        log.warning(
            f'Package "{package_py.name}" does not define a valid source')
        return None


def collect_recipes():
    '''
    Collect all the recipes under PKG_RECIPE_ROOT and return a single dictionary
    containing all the build info

    Package recipes are stored as a tree:
        $PKG_RECIPE_ROOT
        |
        |- imath
        |   |- 3.0.0
        |       |- package.py
        |- oiio
        |   |- 2.2.1.0
        |   |   |- package.py
        |   |- 2.1.10.0
        |       |- package.py

    Where the package.py contains the extra variables 'repo', 'branch' and 
    'build_cmd'
    '''

    log.debug(f'PKG_RECIPE_ROOT = {PKG_RECIPE_ROOT}')

    # Recurse the tree(s) under PKG_RECIPE_ROOT to find recipes
    recipe_roots = PKG_RECIPE_ROOT.split(os.pathsep)
    for recipe_root in recipe_roots:
        recipe_dirs = os.listdir(recipe_root)
        RECIPES = {}
        for name in recipe_dirs:
            version_dirs = os.listdir(os.path.join(recipe_root, name))
            rcp = {}
            versions_dict = {}
            for version in version_dirs:
                package_filename = os.path.join(
                    recipe_root, name, version, 'package.py')
                package_py = imp.load_source(f'{name}-{version}', package_filename)

                # Get the source from the package.py
                # If one isn't defined, or it's improperly defined, we can't
                # use this package
                source = get_source_from_package(package_py)
                if source is None:
                    continue

                # get the build command if there is one, otherwise just default
                # to standard cmake
                build_cmd = ['rez-build -b cmake --install']
                try:
                    build_cmd = package_py.build_cmd
                except AttributeError:
                    pass

                versions_dict[version] = {
                    # 'repo': package_py.repo,
                    # 'branch': package_py.branch,
                    'source': source,
                    'build_cmd': build_cmd,
                    'package_filename': package_filename
                }

            if not versions_dict:
                log.error(f'Package {name} does not define any versions')
                continue

            rcp['name'] = name
            rcp['versions'] = versions_dict
            RECIPES[name] = rcp

    return RECIPES


def main():
    global OPT_REDOWNLOAD_FILES
    global OPT_NUM_CORES
    args = docopt(__doc__)

    name = args['<name>']
    versions = args['<version>']
    OPT_REDOWNLOAD_FILES = args['--redownload-files']
    OPT_NUM_CORES = int(args['--num-cores'] or multiprocessing.cpu_count())
    log.setLevel(logging.DEBUG)

    # check that PKG_ROOT exists, as we're not responsible for creating it
    if not os.path.isdir(PKG_ROOT):
        log.critical(
            f'Package installation root does not exist (PKG_ROOT="{PKG_ROOT}"')
        sys.exit(1)

    # Create PKG_BUILD_ROOT
    try:
        os.makedirs(PKG_BUILD_ROOT, exist_ok=True)
    except Exception as e:
        log.critical(
            f'Could not create build directory "{PKG_BUILD_ROOT}": {str(e)}')
        sys.exit(2)

    RECIPES = collect_recipes()

    # Check that we actually have a recipe for the package we want to build
    if name not in RECIPES.keys():
        log.error(
            f'Requested to build package {name}:{versions}, but no valid recipe found for it in "{PKG_RECIPE_ROOT}"')
        sys.exit(3)

    recipe = RECIPES[name]

    # Check that we have recipes for the versions we've requested
    selected_recipes = {}
    if not versions:
        log.critical(
            f'No versions supplied for package "{name}". Please supply a list of versions to build. Known versions are: {sorted(recipe["versions"].keys())}')
        sys.exit(4)
    else:
        for v in versions:
            spec = SimpleSpec(v)
            # build a list of versions that match our spec
            matching_versions = []
            for rv in recipe['versions'].keys():
                ver = Version(rv)
                if ver in spec:
                    matching_versions.append(ver)

            matching_versions.sort()
            print(f'{spec} found matching versions {matching_versions}')
            # select the latest version we have a recipe for that matches the desired spec
            if matching_versions:
                sel = str(matching_versions[-1])
                selected_recipes[sel] = recipe['versions'][sel]
            else:
                log.error(
                    f'No version matching spec "{spec}" found for recipe "{name}"')

    log.info(
        f'Selected versions {list(selected_recipes.keys())} for package {name}')
    for version, rcp in selected_recipes.items():
        print_header(f'Building package {name} {version}')
        build_package(name, version, rcp['source'],
                      rcp['build_cmd'], rcp['package_filename'])


if __name__ == '__main__':
    main()
