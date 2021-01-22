name = "cuda"
version = "10.2.89"

def commands():
    env.CUDA_TOOLKIT_ROOT_DIR = "{root}"
    env.CUDA_ROOT = "{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib64")

source = { 'runfile': 'https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run'}
build_cmd = [
    'sh cuda_10.2.89_440.33.01_linux.run --silent --toolkit --installpath=%PKG_INSTALL_DIR%',
    'cp package.py %PKG_INSTALL_DIR%'
]