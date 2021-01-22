name='osl'
version = '1.8.15'
requires = ['oiio-1.8', 'llvm-6']

def commands():
    env.OSL_ROOT='{root}'
    env.OSL_ROOT_DIR='{root}'
    env.OSL_LOCATION='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'git@github.com:imageworks/OpenShadingLanguage.git', 'branch': 'Release-1.8.15'}
build_cmd = [
    'rez-build -b cmake --install -- -DCMAKE_CXX_FLAGS="-Wno-deprecated -Wno-deprecated-declarations" -DCMAKE_CXX_STANDARD=14 -DOSL_BUILD_TESTS=OFF'
]
