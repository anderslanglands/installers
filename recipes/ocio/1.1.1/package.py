name = 'ocio'
version = '1.1.1'

requires = []

def commands():
    env.OCIO_ROOT="{root}"
    env.OpenColorIO_ROOT="{root}"
    env.OCIO_ROOT_DIR="{root}"
    env.OCIO_HOME="{root}"
    env.OCIO_LOCATION="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")


source = {'repo': 'https://github.com/AcademySoftwareFoundation/OpenColorIO.git', 'branch': 'v1.1.1'}
build_cmd = [
    'rez-build --install -- -DCMAKE_CXX_FLAGS="-Wno-deprecated-declarations -Wno-unused-function"'
]