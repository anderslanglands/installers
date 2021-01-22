name = 'materialx'
version = '1.37.4'

requires = []

build_requires = ['pybind11']

def commands():
    env.MATERIALX_ROOT='{root}'
    env.MATERIALX_STDLIB_DIR='{root}/documents/Libraries/stdlib'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
    env.PYTHONPATH.append('{root}/python')

source = {'repo': 'git@github.com:materialx/MaterialX.git', 'branch': 'v1.37.4'}
build_cmd = [
    'rez-build -b cmake --install -- -DMATERIALX_BUILD_PYTHON=ON -DMATERIALX_BUILD_VIEWER=ON -DPython_EXECUTABLE=/usr/bin/python -DPYTHON_EXECUTABLE=/usr/bin/python'
]