#!/usr/bin/env bash

pushd $HOME/Downloads

mkdir -p ${HOME}/packages/tbb

wget https://github.com/oneapi-src/oneTBB/releases/download/2019_U9/tbb2019_20191006oss_lin.tgz
tar xf tbb2019_20191006oss_lin.tgz
mv tbb2019_20191006oss ${HOME}/packages/tbb/2019.9

cp ${HOME}/packages/tbb/2019.9/lib/intel64/gcc4.8/* ${HOME}/packages/tbb/2019.9/lib

echo 'name = "tbb"
version = "2019.9"

def commands():
    env.TBB_ROOT = "{root}"
    env.TBB_ROOT_DIR = "{root}"
    env.LD_LIBRARY_PATH.append("{root}/lib")
' > $HOME/packages/tbb/2019.9/package.py