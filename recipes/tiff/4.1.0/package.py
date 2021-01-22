name='tiff'
version = '4.1.0'
requires = []

def commands():
    env.TIFF_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://gitlab.com/libtiff/libtiff.git', 'branch': 'v4.1.0'}
build_cmd = [
    'rez-build -b cmake --install -- -DCMAKE_CXX_FLAGS="-Wno-unused-function -Wno-deprecated-declarations -Wno-cast-qual -Wno-write-strings"'
]