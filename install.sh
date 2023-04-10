#!/bin/bash

# 从 packages.txt 文件中读取要安装的软件包列表
packages=$(cat packages.txt)

# 循环遍历软件包列表，并使用 apt-get 命令安装软件包
for package in $packages
do
    # 检查软件包是否已安装
    if ! dpkg -s $package > /dev/null 2>&1; then
        # 如果软件包未安装，则使用 apt-get 命令安装软件包
        echo "Installing package: $package"
        apt-get install -y $package
    else
        echo "Package $package is already installed"
    fi
done
