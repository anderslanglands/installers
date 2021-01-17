#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=oiio


PKG_VERSION=2.2.10.1
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch v2.2.10.1 https://github.com/OpenImageIO/oiio.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = ['boost-1.73', 'openexr-2.5', 'ocio-1.1', 'giflib-5.2', 'tiff-4.1', 'jpegturbo-2.0', 'png-1.6', 'raw-0.20', 'pugixml-1.10', 'webp-1.1', 'zlib-1.2', 'tbb-2019', 'ptex-2.3', 'openvdb-7.2']

def commands():
    env.OIIO_ROOT='{root}'
    env.OpenImageIO_ROOT='{root}'
    env.OIIO_ROOT_DIR='{root}'
    env.OPENIMAGEIO_ROOT_DIR='{root}'
    env.OIIO_HOME='{root}'
    env.OIIO_LOCATION='{root}'

    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    rez-build -b cmake --install -- -Dpybind11_ROOT=$HOME/packages/pybind11/2.6.1 -DCMAKE_CXX_STANDARD=14
popd



PKG_VERSION=2.1.19.0
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch Release-2.1.19.0 https://github.com/OpenImageIO/oiio.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = ['boost-1.73', 'openexr-2.5', 'ocio-1.1', 'giflib-5.2', 'tiff-4.1', 'jpegturbo-2.0', 'png-1.6', 'raw-0.20', 'pugixml-1.10', 'webp-1.1', 'zlib-1.2', 'tbb-2019', 'ptex-2.3', 'openvdb-7.2']

def commands():
    env.OIIO_ROOT='{root}'
    env.OpenImageIO_ROOT='{root}'
    env.OIIO_ROOT_DIR='{root}'
    env.OPENIMAGEIO_ROOT_DIR='{root}'
    env.OIIO_HOME='{root}'
    env.OIIO_LOCATION='{root}'

    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    rez-build -b cmake --install -- -Dpybind11_ROOT=$HOME/packages/pybind11/2.6.1 -DCMAKE_CXX_STANDARD=14
popd



PKG_VERSION=1.8.17
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch Release-${PKG_VERSION} https://github.com/OpenImageIO/oiio.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = ['boost-1.73', 'openexr-2.5', 'ocio-1.1', 'giflib-5.2', 'tiff-4.1', 'jpegturbo-2.0', 'png-1.6', 'raw-0.20', 'pugixml-1.10', 'webp-1.1', 'zlib-1.2', 'tbb-2019', 'ptex-2.3', 'openvdb-7.2']

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
" > package.py

    echo 'set(CMAKE_FIND_ROOT_PATH "$ENV{TIFF_ROOT};$ENV{JPEGTURBO_ROOT};$ENV{GIFLIB_ROOT};$ENV{OCIO_ROOT};$ENV{PNG_ROOT};$ENV{RAW_ROOT};$ENV{WEBP_ROOT}")' > src/cmake/rezbuild.cmake

    echo 'diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8a08407..f316b15 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -60,6 +60,7 @@ set (CMAKE_MODULE_PATH
 include (oiio_macros)
 include (platform)
 include (compiler)   # All the C++ and compiler related options live here
+include (rezbuild)


 option (VERBOSE "Print lots of messages while compiling" OFF)
' > rezbuild.patch

    git apply rezbuild.patch

    rez-build -b cmake --install -- -Dpybind11_ROOT=$HOME/packages/pybind11/2.6.1 -DCMAKE_CXX_STANDARD=14
popd


