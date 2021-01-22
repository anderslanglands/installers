name="partio"
version = "1.14.0"
requires = []

def commands():
    env.PARTIO_ROOT="{root}"
    env.PARTIO_HOME="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")
    env.PYTHONPATH.append("{root}/lib/python2.7/site-packages")

source = {'repo': 'https://github.com/wdas/partio.git', 'branch': 'v1.14.0'}
