#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=tiff
PKG_VERSION=4.1.0
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch v4.1.0 https://gitlab.com/libtiff/libtiff.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = []

def commands():
    env.TIFF_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    rez-build -b cmake --install -- -DCMAKE_CXX_FLAGS="-Wno-unused-function -Wno-deprecated-declarations -Wno-cast-qual -Wno-write-strings"
popd
