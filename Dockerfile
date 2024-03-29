# docker build -t miniob .
FROM ubuntu:latest

ARG HOME_DIR=/root
ARG MYSQL_CONFIG_DIR=${HOME_DIR}/docker

ENV LANG=en_US.UTF-8

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER root

RUN sed -i "s/security.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list && \
    sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list && \
    sed -i "s/security-cdn.ubuntu.com/mirrors.aliyun.com/" /etc/apt/sources.list
RUN apt-get clean && apt-get update
RUN apt-get install -y cmake \
    git \
    wget \
    flex \
    gdb \
    gcc \
    g++ \
    diffutils \
    vim \
    htop \
    bat \
    rsync \
    sudo \
    curl \
    zsh \
    openssh-server \
    openssh-client \
    libzstd-dev \
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
    bzip2 \
    pkg-config \
    lld \
    doxygen

# change root password
RUN echo "root:root" | chpasswd
RUN mkdir /var/run/sshd

# install zsh and on-my-zsh
RUN git clone https://gitee.com/mirrors/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && sed -i "s/robbyrussell/bira/" ~/.zshrc \
    && usermod --shell /bin/zsh root \
    && echo "export LD_LIBRARY_PATH=/usr/local/lib64:\$LD_LIBRARY_PATH" >> ~/.zshrc

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && sed -i 's/^plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting z /' ~/.zshrc

RUN git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/.powerlevel10k

RUN mkdir -p ${MYSQL_CONFIG_DIR}/bin
RUN mkdir -p ${MYSQL_CONFIG_DIR}/data
RUN mkdir -p ${MYSQL_CONFIG_DIR}/config
RUN mkdir -p /root/code
RUN groupadd mysql && useradd -r -g mysql -s /bin/false mysql

WORKDIR /root
