name='giflib'
version = '5.2.1'
requires = []

def commands():
    env.GIF_ROOT='{root}'
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'tar': 'https://downloads.sourceforge.net/project/giflib/giflib-5.2.1.tar.gz'}
build_cmd = [
    'make install PREFIX=%PKG_INSTALL_DIR%',
    'cp package.py %PKG_INSTALL_DIR%'
]
