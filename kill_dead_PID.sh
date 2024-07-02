#!/bin/bash

# 获取处于 "D"、"Z"、"T"、"t" 状态的进程 PID
pids=$(ps -eo state,pid | awk '$1 == "D" || $1 == "Z" || $1 == "T" || $1 == "t" {print $2}')

# 尝试杀死这些进程
for pid in $pids; do
    kill -9 $pid
    if [ $? -eq 0 ]; then
        echo "成功杀死进程 $pid"
    else
        echo "未能成功杀死进程 $pid"
    fi
done
