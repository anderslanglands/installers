#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                       Building pybind11 v2.6.1                              #
#                                                                             #
###############################################################################
"
set -u
SRC_DIR=$HOME/code/pybind11
mkdir -p $SRC_DIR/..
rm -rf SRC_DIR

git clone --depth 1 --branch v2.6.1 https://github.com/pybind/pybind11.git $SRC_DIR
pushd $SRC_DIR
    echo 'name="pybind11"
version = "2.6.1"
requires = []

def commands():
    env.pybind11_ROOT="{root}"
' > package.py

    rez-build --install -- -DPython_EXECUTABLE=/usr/bin/python -DPYTHON_EXECUTABLE=/usr/bin/python -DDOWNLOAD_CATCH=ON
popd

