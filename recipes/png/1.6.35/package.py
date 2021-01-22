name='png'
version = '1.6.35'
requires = []

def commands():
    env.PNG_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')


source = {'repo': 'https://github.com/glennrp/libpng.git', 'branch': 'v1.6.35'}
build_cmd = [
    'rez-build -b cmake --install -- -DPNG_EXECUTABLES=OFF -DPNG_TESTS=OFF'
]