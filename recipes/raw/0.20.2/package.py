name='raw'
version = '0.20.2'
requires = []

def commands():
    env.RAW_ROOT='{root}'
    env.LIBRAW_ROOT='{root}'
    env.LibRaw_ROOT='{root}'
    env.LibRaw_LIBRARY_DIR='{root}/lib'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://github.com/LibRaw/LibRaw.git', 'branch': '0.20.2'}
build_cmd = [
    'aclocal',
    'autoreconf --install',
    './configure --prefix=%PKG_INSTALL_DIR%',
    'make -j %OPT_NUM_CORES% && make install',
    'cp package.py %PKG_INSTALL_DIR%',

]