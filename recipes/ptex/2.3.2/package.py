name="ptex"
version = "2.3.2"
requires = []

def commands():
    env.PTEX_ROOT="{root}"
    env.PTEX_ROOT_DIR="{root}"
    env.PTEX_HOME="{root}"
    env.PTEX_LOCATION="{root}"
    env.PATH.append("{root}/bin")

source = {'repo': 'https://github.com/wdas/ptex.git', 'branch': 'v2.3.2'}