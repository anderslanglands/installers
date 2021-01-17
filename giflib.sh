#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=giflib
PKG_VERSION=5.2.1
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

pushd $HOME/code
curl --location https://downloads.sourceforge.net/project/giflib/giflib-${PKG_VERSION}.tar.gz -o giflib.tar.gz
tar xf giflib.tar.gz && rm giflib.tar.gz

pushd $SRC_DIR
    cp Makefile Makefile.old
    curl --location https://sourceforge.net/p/giflib/bugs/_discuss/thread/4e811ad29b/c323/attachment/Makefile.patch -o Makefile.patch
    patch -p0 < Makefile.patch

    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = []

def commands():
    env.GIF_ROOT='{root}'
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    make install PREFIX=${HOME}/packages/${PKG_NAME}/${PKG_VERSION}
    cp package.py $TRG_DIR
popd
popd
