name="boost"
version="1.73.0"
requires=[]

def commands():
    env.BOOST_ROOT="{root}"

source = {'tar': 'https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.bz2'}
build_cmd = [
    './bootstrap.sh', 
    './b2 install --prefix=%PKG_INSTALL_DIR%',
    'cp package.py %PKG_INSTALL_DIR%'
]

