#!/usr/bin/env bash

set -e

PKG_NAME=alembic
PKG_VERSION=1.7.16

function title_block() {
    local width=$(tput cols)
    local line=`printf "#%.0s" $(seq 1 $width)`
    printf '%s\n\n' "$line"
    printf "%*s\n\n" $(((${#1}+$width)/2)) "$1"
    printf '%s\n' "$line"
}

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch 1.7.16 https://github.com/alembic/alembic.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = ['boost-1.73', 'openexr-2']

def commands():
    env.ALEMBIC_ROOT='{root}'
    env.ALEMBIC_ROOT_DIR='{root}'
    env.ALEMBIC_DIR='{root}'
    env.ALEMBIC_HOME='{root}'
    env.ALEMBIC_LOCATION='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > package.py

    rez-build -b cmake --install 
popd
