# docker build -t miniob .
FROM ubuntu:latest

ARG HOME_DIR=/root
ARG DOCKER_CONFIG_DIR=${HOME_DIR}/docker

ENV LANG=en_US.UTF-8

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER root

RUN sed -i "s/security.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list && \
    sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list && \
    sed -i "s/security-cdn.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list
RUN apt-get clean && apt-get update

RUN apt install -y cmake git wget flex gdb gcc g++ diffutils vim htop bat rsync sudo curl
RUN apt install -y openssh-server openssh-client
RUN apt install -y libzstd-dev \
    libldap2-dev \
    libsasl2-dev libldap2-dev \
    liblz4-dev \
    libprotobuf-dev \
    libprotoc-dev \
    libcurl4-openssl-dev \
    libncurses-dev \
    bisonc++ \
    libsasl2-dev \
    libldap-common \
    libevent-dev \
    libudev-dev \
    dpkg-dev \
    bzip2\
    pkg-config

# change root password
RUN echo "root:root" | chpasswd
RUN mkdir /var/run/sshd

# install zsh and on-my-zsh
RUN apt install -y zsh \
    && git clone https://gitee.com/mirrors/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && sed -i "s/robbyrussell/bira/" ~/.zshrc \
    && usermod --shell /bin/zsh root \
    && echo "export LD_LIBRARY_PATH=/usr/local/lib64:\$LD_LIBRARY_PATH" >> ~/.zshrc

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && sed -i 's/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting z /' ~/.zshrc

RUN git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/.powerlevel10k

RUN mkdir -p ${DOCKER_CONFIG_DIR}/bin
RUN mkdir -p ${DOCKER_CONFIG_DIR}/config
RUN mkdir -p /root/code

RUN wget https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/llvm.sh && chmod +x llvm.sh
RUN  sudo ./llvm.sh  all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt
RUN wget https://www.openssl.org/source/openssl-1.1.1t.tar.gz

RUN groupadd mysql && useradd -r -g mysql -s /bin/false mysql

WORKDIR /root

# copy vscode config files
# COPY config/* ${DOCKER_CONFIG_DIR}/config/

# copy starter scripts
# COPY bin/* ${DOCKER_CONFIG_DIR}/bin/

#RUN chmod +x ${DOCKER_CONFIG_DIR}/bin/*
