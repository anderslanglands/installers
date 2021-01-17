#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                       Building partio 1.14.0                                #
#                                                                             #
###############################################################################
"

SRC_DIR=$HOME/code/partio-1.14.0
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR

git clone --depth 1 --branch v1.14.0 https://github.com/wdas/partio.git $SRC_DIR
pushd $SRC_DIR
    echo 'name="partio"
version = "1.14.0"
requires = []

def commands():
    env.PARTIO_ROOT="{root}"
    env.partio_ROOT="{root}"
    env.PARTIO_HOME="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")
    env.PYTHONPATH.append("{root}/lib/python2.7/site-packages")
' > package.py

    rez-build -b cmake --install 
popd


