name="openexr"
version = "2.4.2"
requires = ["boost-1.73"]

def commands():
    env.ILMBASE_HOME="{root}"
    env.ILMBASE_ROOT="{root}"
    env.ILMBASE_ROOT_DIR="{root}"
    env.OPENEXR_HOME="{root}"
    env.OPENEXR_ROOT="{root}"
    env.OpenEXR_ROOT="{root}"
    env.OPENEXR_ROOT_DIR="{root}"
    env.OPENEXR_LOCATION="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")
    env.PKG_CONFIG_PATH.append("{root}/lib/pkgconfig")
    env.CMAKE_PREFIX_PATH.append("{root}/lib/cmake")
    env.OPENEXR_LIB_SUFFIX="-2_5"

source = {'repo': 'https://github.com/AcademySoftwareFoundation/openexr.git', 'branch': 'v2.4.2'}