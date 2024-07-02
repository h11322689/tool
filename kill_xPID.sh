#!/bin/bash

echo "请输入要杀死的线程号："
read thread_id

# 检查输入是否为空
if [ -z "$thread_id" ]; then
    echo "您未输入线程号，脚本退出。"
    exit 1
fi

# 尝试杀死指定线程号的进程
kill -9 $thread_id
echo "已尝试杀死线程号为 $thread_id 的进程"


