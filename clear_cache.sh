#!/bin/bash

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
    echo "请以 root 权限运行此脚本"
    exit
fi

# 清理 APT 缓存
sudo apt-get clean

# 自动清理无用的依赖项
sudo apt-get autoremove

# 清理临时文件
sudo rm -rf /tmp/*

# 清理用户缓存
rm -rf ~/.cache/*

# 清理日志文件（需谨慎操作）
sudo find /var/log -name "*.gz" -type f -mtime +7 -delete  # 仅删除 7 天前的.gz 日志文件

# 清理 DNS 缓存（如果安装了 nscd）
if dpkg -l | grep -q nscd; then
    sudo /etc/init.d/nscd restart
else
    echo "nscd 未安装，跳过 DNS 缓存清理"
fi

# 清除 PageCache、dentries 和 inodes 缓存
sudo sync
sudo echo 1 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 3 > /proc/sys/vm/drop_caches

# 关闭 Swap 分区
sudo swapoff -a

# 重新启用 Swap 分区
sudo swapon -a

echo "缓存清理完成"
