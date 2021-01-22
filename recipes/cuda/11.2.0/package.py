name = "cuda"
version = "11.2.0"

def commands():
    env.CUDA_TOOLKIT_ROOT_DIR = "{root}"
    env.CUDA_ROOT = "{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib64")

source = { 'runfile': 'https://developer.download.nvidia.com/compute/cuda/11.2.0/local_installers/cuda_11.2.0_460.27.04_linux.run'}
build_cmd = [
    'sh cuda_11.2.0_460.27.04_linux.run --silent --toolkit --installpath=%PKG_INSTALL_DIR%',
    'cp package.py %PKG_INSTALL_DIR%'
]