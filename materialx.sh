#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=materialx
PKG_VERSION=1.37.4
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --recursive --depth 1 --branch v${PKG_VERSION} git@github.com:materialx/MaterialX.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = []
build_requires = ['pybind11']

def commands():
    env.MATERIALX_ROOT='{root}'
    env.MATERIALX_STDLIB_DIR='{root}/documents/Libraries/stdlib'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
    env.PYTHONPATH.append('{root}/python')
" > package.py

    rez-build -b cmake --install -- -DMATERIALX_BUILD_PYTHON=ON -DMATERIALX_BUILD_VIEWER=ON -DPython_EXECUTABLE=/usr/bin/python -DPYTHON_EXECUTABLE=/usr/bin/python
popd