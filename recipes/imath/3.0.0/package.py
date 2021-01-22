name = 'imath'
version='3.0.0'

requires = []
build_requires = ['boost-1.73']

def commands():
    env.IMATH_ROOT = '{root}'
    env.IMATH_HOME = '{root}'
    env.IMATH_LOCATION = '{root}'
    env.Imath_ROOT = '{root}'
    env.CMAKE_MODULE_PATH = '{root}/lib/cmake'
    env.CMAKE_MODULE_PATH.append('{root}/lib/cmake')
    env.PKG_CONFIG_PATH.append('{root}/lib/pkgconfig')

source = {'repo': 'git@github.com:AcademySoftwareFoundation/Imath.git', 'commit': '8916ff5' }
build_cmd = [
    'rez-build -b cmake --install'
]
