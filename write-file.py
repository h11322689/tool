'''
# 脚本名称: FileGenerationScript
# 作用: 此脚本用于在 Ubuntu 系统中生成一个 1.5T 大小的文件，文件会被分割为 500MB 的单位分别存储在不同的文件中（如 bigfile_1.txt、bigfile_2.txt 等）。在生成过程中，会在终端实时打印生成进度、经过时间和写入速率等信息，并将信息记录到日志文件中。
# 使用方法: 直接在支持 Python 运行的环境中执行此脚本即可。
# 作者: lihao
# 时间: 2024 年 7 月 18 日
# 版权: 未经许可，不得随意修改和传播此脚本
# 注意事项: 
    - 运行此脚本前，请确保所在目录有足够的存储空间。
    - 生成过程可能需要较长时间，具体取决于系统性能和磁盘读写速度。
'''
import os
import time
import logging

# 计算 2.5T（2.5 * 1024^4 字节）对应的字节数
total_size_in_bytes = int(2.5 * 1024 * 1024 * 1024 * 1024)

# 每次写入的字节数（500MB）
write_size = 1024 * 1024 * 500

file_index = 1
written_bytes = 0
prev_percentage = 0  # 记录上一次打印的百分比
prev_time = time.time()  # 记录上一次打印进度的时间
last_print_time = time.time()  # 记录上一次打印的时间

# 设置日志记录器
logging.basicConfig(filename='generation_log.txt', level=logging.INFO)

while written_bytes < total_size_in_bytes:
    file_name = f'bigfile_{file_index}.txt'
    with open(file_name, 'wb') as f:
        remaining_bytes_in_file = write_size
        while remaining_bytes_in_file > 0 and written_bytes < total_size_in_bytes:
            current_write_size = min(remaining_bytes_in_file, total_size_in_bytes - written_bytes)
            f.write(b'\0' * current_write_size)
            written_bytes += current_write_size
            remaining_bytes_in_file -= current_write_size

    # 计算已写入的百分比
    percentage = int((written_bytes / total_size_in_bytes) * 100)

    # 如果百分比有变化，并且距离上次打印超过 5 秒，才进行打印
    current_time = time.time()
    if percentage > prev_percentage and current_time - last_print_time > 5:
        elapsed_time = current_time - prev_time
        interval_time = current_time - prev_time  # 计算两次打印之间的时间间隔

        # 计算写入速率（单位：MB/s）
        write_speed = (write_size / (1024 * 1024)) / interval_time  

        print(f"已写入 {percentage}%，经过时间: {elapsed_time:.2f} 秒，写入速率: {write_speed:.2f} MB/s")
        logging.info(f"已写入 {percentage}%，经过时间: {elapsed_time:.2f} 秒，写入速率: {write_speed:.2f} MB/s")

        prev_percentage = percentage
        prev_time = current_time
        last_print_time = current_time  # 更新上一次打印的时间

    file_index += 1
