name='webp'
version = '1.1.0'
requires = []

def commands():
    env.WEBP_ROOT='{root}'
    env.Webp_ROOT='{root}'
    env.WebP_ROOT='{root}'
    env.PATH.append('{root}/bin')
    env.LD_LIBRARY_PATH.append('{root}/lib')

source = {'repo': 'https://github.com/webmproject/libwebp.git', 'branch': 'v1.1.0'}
build_cmd = [
    'rez-build -b cmake --install -- -DWEBP_BUILD_ANIM_UTILS=OFF -DWEBP_BUILD_CWEBP=OFF -DWEBP_BUILD_DWEBP=OFF -DWEBP_BUILD_EXTRAS=OFF -DWEBP_BUILD_GIF2WEBP=OFF -DWEBP_BUILD_IMG2WEBP=OFF -DWEBP_BUILD_VWEBP=OFF -DBUILD_SHARED_LIBS=ON -DWEBP_BUILD_WEBPINFO=OFF -DWEBP_BUILD_WEBPMUX=OFF'
]