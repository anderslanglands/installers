name='openvdb'
version = '7.2.1'
requires = ['openexr-2.5', 'tbb-2019', 'blosc-1.21']

def commands():
    env.OPENVDB_ROOT='{root}'
    env.OpenVDB_ROOT='{root}'
    env.OPENVDB_ROOT_DIR='{root}'
    env.OPENVDB_LOCATION='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'git@github.com:AcademySoftwareFoundation/openvdb.git', 'branch': 'v7.2.1'}