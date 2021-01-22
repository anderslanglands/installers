name = 'llvm'
version = '11.0.0'

requires = []

def commands():
    env.LLVM_ROOT='{root}'
    env.LLVM_DIR='{root}'
    env.LLVM_DIRECTORY='{root}'
    env.LLVM_CONFIG_PATH='{root}/bin/llvm-config'
    env.PATH.append('{root}/bin')

source = {'custom': [
    'wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/llvm-11.0.0.src.tar.xz',
    'wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-11.0.0.src.tar.xz',
    'wget https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.0/clang-tools-extra-11.0.0.src.tar.xz',
    'tar xf llvm-11.0.0.src.tar.xz',
    'tar xf clang-11.0.0.src.tar.xz',
    'tar xf clang-tools-extra-11.0.0.src.tar.xz',
    'rm -rf clang',
    'mv clang-11.0.0.src clang',
    'rm -rf clang-tools-extra',
    'mv clang-tools-extra-11.0.0.src clang-tools-extra',
    'cp package.py llvm-11.0.0.src',
    'cd llvm-11.0.0.src && rez-build -b cmake --install -- -DLLVM_ENABLE_RTTI=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"'
]}