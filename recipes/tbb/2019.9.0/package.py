name = "tbb"
version = "2019.9"

def commands():
    env.TBB_ROOT = "{root}"
    env.TBB_ROOT_DIR = "{root}"
    env.LD_LIBRARY_PATH.append("{root}/lib")

source = {'custom':[
    'wget https://github.com/oneapi-src/oneTBB/releases/download/2019_U9/tbb2019_20191006oss_lin.tgz',
    'tar xf tbb2019_20191006oss_lin.tgz',
    'mv tbb2019_20191006oss %PKG_INSTALL_DIR%',
    'cp %PKG_INSTALL_DIR%/lib/intel64/gcc4.8/* %PKG_INSTALL_DIR%/lib/',
    'cp package.py %PKG_INSTALL_DIR%'
]}