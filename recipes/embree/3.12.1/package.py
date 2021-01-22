name = 'embree'
version = '3.12.1'

def commands():
    env.EMBREE_ROOT = '{root}'
    env.EMBREE_LOCATION = '{root}'
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'bintar': 'https://github.com/embree/embree/releases/download/v3.12.1/embree-3.12.1.x86_64.linux.tar.gz'}
build_cmd = []
