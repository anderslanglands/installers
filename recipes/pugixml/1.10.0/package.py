name='pugixml'
version = '1.10.0'
requires = []

def commands():
    env.PUGIXML_ROOT='{root}'
    env.pugixml_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
    env.LD_LIBRARY_PATH.append('{root}/lib64')

source = {'repo': 'https://github.com/zeux/pugixml.git', 'branch': 'v1.10'}
build_cmd = [
    'rez-build -b cmake --install -- -DBUILD_SHARED_LIBS=ON -DBUILD_TESTS=OFF'
]
