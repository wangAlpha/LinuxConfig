#!/bin/zsh
set -x

wget https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh  all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt

sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-15 100
sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-15 100

apt-get update
apt-get -y install \
      xz-utils \
      zlib1g-dev

wget https://www.openssl.org/source/openssl-1.1.1t.tar.gz

