#!/usr/bin/env bash

# First, update everything
sudo apt upgrade

# Next our graphics drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt install nvidia-driver-460

# reboot

# ethernet
sudo apt install net-tools
sudo apt install nfs-common

# realtek drivers from here:
https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software


# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable

# Fish
sudo apt install fish

# Dev

# Rust
sudo apt install curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH = $HOME/.cargo/bin:$PATH
cargo install ripgrep
cargo install fd-find

# GCC
sudo apt install git
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt install gcc-8 gcc-9 gcc-10 g++-8 g++-9 g++-10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 95 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 90 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10

sudo apt upgrade

## cmake
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo apt-get update
sudo apt-get install cmake

sudo apt install fasd
sudo apt install libx11-dev
sudo apt install libssl-dev
sudo apt install python-dev python-pip
sudo apt install libtool automake
sudo apt install libbz2-dev
sudo apt install xorg-dev
sudo apt install libglew-dev libglfw3-dev freeglut3-dev
sudo apt install qtbase5-dev qt5-default
sudo apt install flex bison
sudo apt install nfs-kernel-server nfs-common
sudo apt install doxygen graphviz
python -m pip install pytest numpy PySide2

# Start build env
mkdir code && cd code
pushd

git clone https://github.com/anderslanglands/dotfiles.git
rm -f ~/.bashrc
ln -s $HOME/code/dotfiles/bashrc ~/.bashrc
source ~/.bashrc

# fonts
wget -O /tmp/hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
unzip /tmp/hack.zip -d ~/.fonts
wget -O /tmp/hasklig.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hasklig.zip
unzip /tmp/hasklig.zip -d ~/.fonts

git clone https://github.com/anderslanglands/SF-Mono-Nerd-Font.git
cp SF-Mono-Nerd-Font/*.otf ~/.fonts

fc-cache -fv

# Alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
sudo apt install libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev
cargo build --release
sudo cp target/release/alacritty /usr/local/bin/

popd

mkdir ~/.config/alacritty
ln -s ~/code/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# nodejs (for CoC etc)
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install -y nodejs

# nvim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim

ln -s ~/code/dotfiles/nvim ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugInstall +qa

# rez
git clone --depth 1 --branch 2.72.0 https://github.com/nerdvegas/rez.git code/rez
pushd code/rez
python ./install.py -v ~/packages
export PATH = $HOME/packages/bin/rez:$PATH
rez-bind platform
rez-bind arch
rez-bind os
rez-bind python

popd

# VFX Platform

## OCIO


# Houdini hqeue
# hquser/hqpass
# http://alwsk18:5000
# http://alwsk18:5000/help
# bash -c "source houdini_setup_bash; exec bash"