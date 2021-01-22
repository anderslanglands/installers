name='zlib'
version = '1.2.11'
requires = []

def commands():
    env.ZLIB_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://github.com/madler/zlib.git', 'branch': 'v1.2.11'}