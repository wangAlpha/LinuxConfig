set -x

wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
# sudo ./llvm.sh <version number> all
# or
sudo ./llvm.sh all

sudo apt-get update
sudo apt-get -y install \
      build-essential \
      cmake \
      curl \
      xz-utils \
      doxygen \
      git \
      pkg-config \
      zlib1g-dev \
      lld


# sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-13 100
# sudo update-alternatives --install /usr/bin/cc cc /usr/bin/clang-13 100
