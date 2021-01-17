#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=blosc
PKG_VERSION=1.21.0
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch v${PKG_VERSION} git@github.com:Blosc/c-blosc.git $SRC_DIR

pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = []

def commands():
    env.BLOSC_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    rez-build -b cmake --install
popd