name='usd'
version = '20.8.0'
requires = ['osl-1.11', 'alembic-1.7', 'opensubdiv-3.4', 'embree-3.12', 'tbb-2019', 'materialx-1.37']

def commands():
    env.USD_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')
    env.PYTHONPATH.append('{root}/lib/python')

source = {'repo': 'git@github.com:PixarAnimationStudios/USD.git', 'branch': 'v20.08'}
build_cmd = [
    'rez-build -b cmake --install -- -DPXR_BUILD_DOCUMENTATION=ON -DPXR_ENABLE_OSL_SUPPORT=ON -DPXR_BUILD_OPENIMAGEIO_PLUGIN=ON -DPXR_BUILD_EMBREE_PLUGIN=ON -DPXR_BUILD_ALEMBIC_PLUGIN=ON -DPXR_ENABLE_HDF5_SUPPORT=OFF -DPXR_BUILD_MATERIALX_PLUGIN=ON'
]