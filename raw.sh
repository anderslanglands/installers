#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=raw
PKG_VERSION=0.20.2
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch 0.20.2 https://github.com/LibRaw/LibRaw.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = []

def commands():
    env.RAW_ROOT='{root}'
    env.LIBRAW_ROOT='{root}'
    env.LibRaw_ROOT='{root}'
    env.LibRaw_LIBRARY_DIR='{root}/lib'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    aclocal
    autoreconf --install
    ./configure --prefix=${TRG_DIR}
    make -j 16 && make install

    cp package.py ${TRG_DIR}
popd
