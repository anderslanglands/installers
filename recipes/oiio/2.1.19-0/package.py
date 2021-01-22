name='oiio'
version = '2.1.19.0'
requires = ['boost-1.73', 'openexr-2.5', 'ocio-1.1', 'giflib-5.2', 'tiff-4.1', 'jpegturbo-2.0', 'png-1.6', 'raw-0.20', 'pugixml-1.10', 'webp-1.1', 'zlib-1.2', 'tbb-2019', 'ptex-2.3', 'openvdb-7.2']
build_requires = ['pybind11']

def commands():
    env.OIIO_ROOT='{root}'
    env.OpenImageIO_ROOT='{root}'
    env.OIIO_ROOT_DIR='{root}'
    env.OPENIMAGEIO_ROOT_DIR='{root}'
    env.OPENIMAGEIOHOME='{root}'
    env.OIIO_HOME='{root}'
    env.OIIO_LOCATION='{root}'

    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://github.com/OpenImageIO/oiio.git', 'branch': 'Release-2.1.19.0'}
build_cmd = [
    'rez-build -b cmake --install -- -DCMAKE_CXX_STANDARD=14'
]
