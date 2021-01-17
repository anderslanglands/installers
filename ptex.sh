#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                         Building Ptex 2.3.2                                 #
#                                                                             #
###############################################################################
"

SRC_DIR=$HOME/code/ptex-2.3.2
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR

git clone --depth 1 --branch v2.3.2 https://github.com/wdas/ptex.git $SRC_DIR
pushd $SRC_DIR
    echo 'name="ptex"
version = "2.3.2"
requires = []

def commands():
    env.PTEX_ROOT="{root}"
    env.PTEX_ROOT_DIR="{root}"
    env.PTEX_HOME="{root}"
    env.PTEX_LOCATION="{root}"
    env.PATH.append("{root}/bin")
' > package.py

    rez-build -b cmake --install 
popd


