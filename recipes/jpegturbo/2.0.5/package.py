name = 'jpegturbo'
version = '2.0.5'

requires = []

def commands():
    env.JPEGTURBO_ROOT='{root}'
    env.JPEGTurbo_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://github.com/libjpeg-turbo/libjpeg-turbo.git', 'branch': '2.0.5'}