#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                         Building OpenEXR 2.5.4                              #
#                                                                             #
###############################################################################
"
mkdir -p $HOME/code
rm -rf $HOME/code/openexr

git clone --depth 1 --branch v2.5.4 https://github.com/AcademySoftwareFoundation/openexr.git $HOME/code/openexr

pushd $HOME/code/openexr
    echo 'name="openexr"
version = "2.5.4"
build_requires = ["boost-1.73"]

def commands():
    env.ILMBASE_HOME="{root}"
    env.ILMBASE_ROOT="{root}"
    env.ILMBASE_ROOT_DIR="{root}"
    env.OPENEXR_HOME="{root}"
    env.OPENEXR_ROOT="{root}"
    env.OpenEXR_ROOT="{root}"
    env.OPENEXR_ROOT_DIR="{root}"
    env.OPENEXR_LOCATION="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")
    env.PKG_CONFIG_PATH.append("{root}/lib/pkgconfig")
    env.CMAKE_MODULE_PATH.append("{root}/lib/cmake")
    env.OPENEXR_LIB_SUFFIX="-2_5"
' > package.py

    rez-build --install
popd

