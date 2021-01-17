#!/usr/bin/env bash

pushd $HOME/Downloads

wget https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda_11.2.0_460.27.04_linux.run
sh cuda_11.2.0_460.27.04_linux.run --silent --toolkit 

mkdir -p $HOME/packages/cuda/11.2.0
echo 'name = "cuda"
version = "11.2.0"

def commands():
    env.CUDA_TOOLKIT_ROOT_DIR = "/usr/local/cuda-11.2"
    env.CUDA_ROOT = "/usr/local/cuda-11.2"
    env.PATH.append("/usr/local/cuda-11.2/bin")
    env.LD_LIBRARY_PATH.append("/usr/local/cuda-11.2/lib64")
' > $HOME/packages/cuda/11.2.0/package.py

wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run
sh cuda_10.2.89_440.33.01_linux.run --silent --toolkit 

mkdir -p $HOME/packages/cuda/10.2.89
echo 'name = "cuda"
version = "10.2.89"

def commands():
    env.CUDA_TOOLKIT_ROOT_DIR = "/usr/local/cuda-10.2"
    env.CUDA_ROOT = "/usr/local/cuda-10.2"
    env.PATH.append("/usr/local/cuda-10.2/bin")
    env.LD_LIBRARY_PATH.append("/usr/local/cuda-10.2/lib64")
' > $HOME/packages/cuda/10.2.89/package.py

wget https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
sh cuda_10.1.243_418.87.00_linux.run --silent --toolkit 

mkdir -p $HOME/packages/cuda/10.1.243
echo 'name = "cuda"
version = "10.1.243"

def commands():
    env.CUDA_TOOLKIT_ROOT_DIR = "/usr/local/cuda-10.1"
    env.CUDA_ROOT = "/usr/local/cuda-10.1"
    env.PATH.append("/usr/local/cuda-10.1/bin")
    env.LD_LIBRARY_PATH.append("/usr/local/cuda-10.1/lib64")
' > $HOME/packages/cuda/10.1.243/package.py

popd