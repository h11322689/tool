#!/bin/bash

# 获取 Ubuntu 版本
ubuntu_version=$(lsb_release -sr)

# 根据版本设置清华源
if [[ "$ubuntu_version" == "18.04" ]]; then
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" > /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list'
elif [[ "$ubuntu_version" == "20.04" ]]; then
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list'
elif [[ "$ubuntu_version" == "22.04" ]]; then
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list'
elif [[ "$ubuntu_version" == "24.04" ]]; then
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar main restricted universe multiverse" > /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-security main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-security main restricted universe multiverse" >> /etc/apt/sources.list'
else
    echo "不支持的 Ubuntu 版本：$ubuntu_version"
    exit 1
fi

# 更新 APT 源
sudo apt update

# 升级已安装的软件包
sudo apt upgrade -y

# 自动清理未使用的依赖包
sudo apt autoremove -y

echo "系统更新和清理完成"
