#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                       Building OpenColorIO 1.1.1                            #
#                                                                             #
###############################################################################
"

SRC_DIR=$HOME/code/ocio-1.1.1
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR

git clone --depth 1 --branch v1.1.1 https://github.com/AcademySoftwareFoundation/OpenColorIO.git $SRC_DIR
pushd $SRC_DIR
    echo 'name="ocio"
version = "1.1.1"
requires = []

def commands():
    env.OCIO_ROOT="{root}"
    env.OpenColorIO_ROOT="{root}"
    env.OCIO_ROOT_DIR="{root}"
    env.OCIO_HOME="{root}"
    env.OCIO_LOCATION="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")
' > package.py

    rez-build --install -- -DCMAKE_CXX_FLAGS="-Wno-deprecated-declarations -Wno-unused-function"
popd

