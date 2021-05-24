#!/bin/bash
set -x
# created by liwang

# 执行该脚本时所在路径
exec_location=`pwd`
# 脚本所在的路径
relative_location=$(cd "$(dirname "$0")"; pwd)
# log file
LOG=$relative_location/../log

# load functions
. $relative_location/utils.sh

# install software
install_software() {
    print_log 'install software...' $LOG
    chmod +x $relative_location/app.sh
    $relative_location/app.sh
    print_log "done" $LOG
}

# config etc files
config_etc() {
    print_log "config etc..." $LOG
    chmod +x $relative_location/etc_conf_apply.sh
    $relative_location/etc_conf_apply.sh
    print_log "done" $LOG
}

# config ssh for github
config_ssh() {
    print_log "config ssh for github..." $LOG

    git config --global user.email "472146630@qq.com"
    git config --global user.name "wangAlpha"

    echo "create ssh key"
    ssh-keygen -t rsa -C "472146630@qq.com"

    echo "your public key:"
    cat $HOME/.ssh/id_rsa.pub
    cat $HOME/.ssh/id_rsa.pub >> $relative_location/../../ssh.key

    print_log "done" $LOG
}

# config mirrors list
config_mirrors() {
    print_log "config mirrors list" $LOG
    sudo pacman-mirrors -c China
    print_log "done" $LOG

}
# config vim
config_vim() {
    print_log "do config for vim..." $LOG
    # vim had been installed?
    check_software vim 'pacman -S --noconfirm'
    # clang had been installed?
    check_software clang 'pacman -S --noconfirm'
    # cmake had been installed?
    check_software cmake 'pacman -S --noconfirm'
    # powerline-fonts
    check_software powerline-fonts 'pacman -S --noconfirm'
    # backup
    backup_file $HOME/.vimrc
    backup_file $HOME/.vim
    # link
    link $relative_location/../res/vim/.vimrc $HOME/
    link $relative_location/../res/vim/.ycm_extra_conf.py $HOME/
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    link $relative_location/../res/vim/colors $HOME/.vim/colors
    vim +PluginInstall +qall
    yaourt -Sy vim-youcompleteme-git
    # TODO git 太慢了
    # $HOME/.vim/bundle/YouCompleteMe/install.sh  --clang-completer --system-libclang
    print_log "done" $LOG
}

# config zsh
config_zsh() {
    print_log "do config for zsh..." $LOG
    check_software zsh 'pacman -S --noconfirm'
    check_software autojump 'pacman -S --noconfirm'
    check_software powerline-fonts 'pacman -S --noconfirm'
    backup_file $HOME/.zshrc
    # oh my zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    link $relative_location/../res/zsh/.zshrc $HOME/.zshrc
    chsh -s /bin/zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

    if [ $? = 0 ]
    then print_log "chsh successfully" $LOG
    else
        print_log "error when chsh" $LOG
    fi
    print_log "done" $LOG
}

config_py() {
    mkdir .config/pip
    echo "[global]
timeout = 60
index-url = http://pypi.douban.com/simple
trusted-host = pypi.douban.com" > $HOME/.config/pip.conf
}

config_ssr() {
  pip3 install genpac
  mkdir $HOME/.ssr; cd .ssr
  genpac --proxy="SOCKS5 127.0.0.1:1080" --gfwlist-proxy="SOCKS5 127.0.0.1:1080" -o autoproxy.pac --gfwlist-url="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
  echo "file:////home/me/.ssr/autoproxy.pac"
}

config_rust() {
    mkdir $HOME/.cargo/config
    rustup toolchain install nightly
    rustup default nightly
    echo '[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"' > $HOME/.cargo/config

    cargo +nightly install rustfmt
    rustup component add llvm-tools-preview
    cargo +nightly install racer
    rustup component add rls-preview --toolchain nightly
    rustup component add rust-analysis --toolchain nightly
}

echo "Configure Pacman"
config_etc
config_mirrors

echo "Update System"
update_system

echo "Install Applications"
install_software

echo "Configure Vim"
config_vim

echo "Configure Zsh"
config_zsh

echo "Configure SSH-KEY"
config_ssh

echo "Configure ssr"
config_ssr

echo "Configure Python3"
config_py

echo "Configure Rust"
config_rust

# echo "Configure Golang"
# config_golang
