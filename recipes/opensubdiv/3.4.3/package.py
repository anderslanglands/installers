name="opensubdiv"
version = "3.4.3"
requires = ["openexr-2", "cuda-10.1", "ptex-2.3"]

def commands():
    env.OPENSUBDIV_ROOT="{root}"
    env.OPENSUBDIV_ROOT_DIR="{root}"
    env.PATH.append("{root}/bin")
    env.LD_LIBRARY_PATH.append("{root}/lib")

source = {'repo': 'https://github.com/PixarAnimationStudios/OpenSubdiv.git', 'branch': 'v3_4_3' }