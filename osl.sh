#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=osl
PKG_VERSION=1.11.10.0
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch Release-1.11.10.0 git@github.com:imageworks/OpenShadingLanguage.git $SRC_DIR

pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = ['oiio-2.2', 'llvm-11', 'partio-1.14']
build_requires = ['pybind11']

def commands():
    env.OSL_ROOT='{root}'
    env.OSL_ROOT_DIR='{root}'
    env.OSL_LOCATION='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    rez-build -b cmake --install -- -DCMAKE_CXX_FLAGS="-Wno-deprecated -Wno-deprecated-declarations" -DCMAKE_CXX_STANDARD=14 -DOSL_BUILD_TESTS=OFF
popd
