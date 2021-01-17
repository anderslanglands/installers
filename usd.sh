#!/usr/bin/env bash

source util.sh

set -e

PKG_NAME=usd
PKG_VERSION=20.08
PKG_TITLE="${PKG_NAME} ${PKG_VERSION}"

title_block "$PKG_NAME $PKG_VERSION"

SRC_DIR=$HOME/code/${PKG_NAME}-${PKG_VERSION}
TRG_DIR=$HOME/packages/${PKG_NAME}/${PKG_VERSION}
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR $TRG_DIR

git clone --depth 1 --branch v${PKG_VERSION} git@github.com:PixarAnimationStudios/USD.git $SRC_DIR
pushd $SRC_DIR
    echo "name='${PKG_NAME}'
version = '${PKG_VERSION}'
requires = ['osl-1.11', 'alembic-1.7', 'osd-3.4', 'embree-3.12', 'tbb-2019', 'materialx-1.37']

def commands():
    env.USD_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
    env.PYTHONPATH.append('{root}/lib/python')
" > package.py

    echo 'diff --git a/cmake/modules/FindAlembic.cmake b/cmake/modules/FindAlembic.cmake
index e1af1da..92ec110 100644
--- a/cmake/modules/FindAlembic.cmake
+++ b/cmake/modules/FindAlembic.cmake
@@ -45,8 +45,8 @@
 #=============================================================================

 set(LIBRARY_PATHS
-    ${ALEMBIC_DIR}/lib/
-    ${ALEMBIC_DIR}/lib/static
+    $ENV{ALEMBIC_ROOT}/lib/
+    $ENV{ALEMBIC_ROOT}/lib/static
     /usr/lib
     /usr/local/lib
     /sw/lib
@@ -122,7 +122,7 @@ endif()

 # Find Alembic include dir
 find_path (ALEMBIC_INCLUDE_DIR Alembic/Abc/All.h
-           HINTS ${ALEMBIC_DIR}/include
+    HINTS $ENV{ALEMBIC_ROOT}/include
 )

 include(FindPackageHandleStandardArgs)
' > rezbuild.patch

    git apply rezbuild.patch

    rez-build -b cmake --install -- -DPXR_BUILD_DOCUMENTATION=ON -DPXR_ENABLE_OSL_SUPPORT=ON -DPXR_BUILD_OPENIMAGEIO_PLUGIN=ON -DPXR_BUILD_EMBREE_PLUGIN=ON -DPXR_BUILD_ALEMBIC_PLUGIN=ON -DPXR_ENABLE_HDF5_SUPPORT=OFF -DPXR_BUILD_MATERIALX_PLUGIN=ON
popd

