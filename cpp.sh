#!/bin/zsh
set -x

wget https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh  all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt

apt-get update
apt-get -y install \
      build-essential \
      cmake \
      curl \
      xz-utils \
      doxygen \
      git \
      pkg-config \
      zlib1g-dev \
      lld


sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-15 100
sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-15 100
