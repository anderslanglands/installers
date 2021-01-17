#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=llvm

PKG_VERSION=11.0.0
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

mkdir -p $SRC_DIR
pushd $SRC_DIR
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/llvm-11.0.0.src.tar.xz
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-11.0.0.src.tar.xz
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-tools-extra-11.0.0.src.tar.xz
    tar xf llvm-11.0.0.src.tar.xz && rm llvm-11.0.0.src.tar.xz
    tar xf clang-11.0.0.src.tar.xz && rm clang-11.0.0.src.tar.xz
    tar xf clang-tools-extra-11.0.0.src.tar.xz && rm clang-tools-extra-11.0.0.src.tar.xz
    mv clang-11.0.0.src clang
    mv clang-tools-extra-11.0.0.src clang-tools-extra
    pushd llvm-11.0.0.src
echo "name='${PKG_NAME}'
version='${PKG_VERSION}'
requires=[]

def commands():
    env.LLVM_ROOT='{root}'
    env.LLVM_DIR='{root}'
    env.LLVM_DIRECTORY='{root}'
    env.LLVM_CONFIG_PATH='{root}/bin/llvm-config'
    env.PATH.append('{root}/bin')
" > package.py

    rez-build -b cmake --install -- -DLLVM_ENABLE_RTTI=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"

    popd
popd




PKG_VERSION=10.0.1
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

mkdir -p $SRC_DIR
pushd $SRC_DIR
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/llvm-10.0.1.src.tar.xz
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang-10.0.1.src.tar.xz
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang-tools-extra-10.0.1.src.tar.xz
    tar xf llvm-10.0.1.src.tar.xz && rm llvm-10.0.1.src.tar.xz
    tar xf clang-10.0.1.src.tar.xz && rm clang-10.0.1.src.tar.xz
    tar xf clang-tools-extra-10.0.1.src.tar.xz && rm clang-tools-extra-10.0.1.src.tar.xz
    mv clang-10.0.1.src clang
    mv clang-tools-extra-10.0.1.src clang-tools-extra
    pushd llvm-10.0.1.src
echo "name='${PKG_NAME}'
version='${PKG_VERSION}'
requires=[]

def commands():
    env.LLVM_ROOT='{root}'
    env.LLVM_DIR='{root}'
    env.LLVM_DIRECTORY='{root}'
    env.LLVM_CONFIG_PATH='{root}/bin/llvm-config'
    env.PATH.append('{root}/bin')
" > package.py

    rez-build -b cmake --install -- -DLLVM_ENABLE_RTTI=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"

    popd
popd


