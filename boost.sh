#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                         Building Boost 1.73.0                               #
#                                                                             #
###############################################################################
"

mkdir -p $HOME/code
rm -rf $HOME/code/boost_1_73_0
pushd $HOME/code
    wget https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.bz2
    tar xf boost_1_73_0.tar.bz2 && rm boost_1_73_0.tar.bz2
    pushd boost_1_73_0
        ./bootstrap.sh
        ./b2 install --prefix=$HOME/packages/boost/1.73.0
    popd
popd

# manually write a package.py for boost
echo 'name="boost"
version="1.73.0"
requires=[]

def commands():
    env.BOOST_ROOT="{root}"
' > $HOME/packages/boost/1.73.0/package.py

