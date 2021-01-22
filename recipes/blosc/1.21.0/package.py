name = 'blosc'
version = '1.21.0'

requires = []

def commands():
    env.BLOSC_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'git@github.com:Blosc/c-blosc.git', 'branch': 'v1.21.0'}
build_cmd = [
    'rez-build -b cmake --install'
]