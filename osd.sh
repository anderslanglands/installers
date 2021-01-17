#!/usr/bin/env bash

echo "
###############################################################################
#                                                                             #
#                       Building OpenSubdiv 3.4.3                             #
#                                                                             #
###############################################################################
"

SRC_DIR=$HOME/code/osd-3.4.3
mkdir -p $SRC_DIR/..
rm -rf $SRC_DIR

git clone --depth 1 --branch v3_4_3 https://github.com/PixarAnimationStudios/OpenSubdiv.git $SRC_DIR
pushd $SRC_DIR
    echo 'name="osd"
version = "3.4.3"
requires = ["openexr-2", "cuda-10.1", "ptex-2.3"]

def commands():
    env.OPENSUBDIV_ROOT="{root}"
    env.OPENSUBDIV_ROOT_DIR="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")
' > package.py

    # Patch to use a not-ancient arch
    echo 'diff --git a/CMakeLists.txt b/CMakeLists.txt
index b69912a..550e669 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -576,7 +576,7 @@ if(CUDA_FOUND)
             if (CUDA_VERSION_MAJOR LESS 6)
                 set( OSD_CUDA_NVCC_FLAGS --gpu-architecture compute_11 )
             else()
-                set( OSD_CUDA_NVCC_FLAGS --gpu-architecture compute_20 )
+                set( OSD_CUDA_NVCC_FLAGS --gpu-architecture compute_70 )
             endif()
         endif()
     endif()' > gpu-arch.patch

     git apply gpu-arch.patch

    rez-build -b cmake --install 
popd


