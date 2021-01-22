name = "cuda"
version = '10.1.243'

def commands():
    env.CUDA_TOOLKIT_ROOT_DIR = "{root}"
    env.CUDA_ROOT = "{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib64")

source = { 'runfile': 'https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run'}
build_cmd = [
    'sh cuda_10.1.243_418.87.00_linux.run --silent --toolkit --installpath=%PKG_INSTALL_DIR%',
    'cp package.py %PKG_INSTALL_DIR%'
]