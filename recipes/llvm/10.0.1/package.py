name = 'llvm'
version = '10.0.1'

requires = []

def commands():
    env.LLVM_ROOT='{root}'
    env.LLVM_DIR='{root}'
    env.LLVM_DIRECTORY='{root}'
    env.LLVM_CONFIG_PATH='{root}/bin/llvm-config'
    env.PATH.append('{root}/bin')

source = {'custom': [
    'wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/llvm-10.0.1.src.tar.xz',
    'wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang-10.0.1.src.tar.xz',
    'wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.1/clang-tools-extra-10.0.1.src.tar.xz',
    'tar xf llvm-10.0.1.src.tar.xz',
    'tar xf clang-10.0.1.src.tar.xz',
    'tar xf clang-tools-extra-10.0.1.src.tar.xz',
    'rm -rf clang',
    'mv clang-10.0.1.src clang',
    'rm -rf clang-tools-extra',
    'mv clang-tools-extra-10.0.1.src clang-tools-extra',
    'cp package.py llvm-10.0.1.src',
    'cd llvm-10.0.1.src && rez-build -b cmake --install -- -DLLVM_ENABLE_RTTI=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"'
]}