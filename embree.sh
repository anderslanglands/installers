#!/usr/bin/env bash

pushd $HOME/Downloads

PKG_NAME=embree
PKG_VERSION=3.12.1

mkdir -p ${HOME}/packages/${PKG_NAME}

wget https://github.com/embree/embree/releases/download/v${PKG_VERSION}/embree-${PKG_VERSION}.x86_64.linux.tar.gz
tar xf embree-${PKG_VERSION}.x86_64.linux.tar.gz && rm embree-${PKG_VERSION}.x86_64.linux.tar.gz
mv embree-${PKG_VERSION}.x86_64.linux ${HOME}/packages/embree/${PKG_VERSION}

echo "name = '${PKG_NAME}'
version = '${PKG_VERSION}'

def commands():
    env.EMBREE_ROOT = '{root}'
    env.EMBREE_LOCATION = '{root}'
    env.LD_LIBRARY_PATH.append('{root}/lib')
" > $HOME/packages/${PKG_NAME}/${PKG_VERSION}/package.py