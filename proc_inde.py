import os
import re

def convert_indentation(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    new_lines = []
    indent_level = 0
    for line in lines:
        # 处理缩进
        indent = re.match(r'^(\s*)', line)
        if indent:
            current_indent = indent.group(1)
            current_indent_level = len(current_indent) // 3  # 每 3 个空格为一个缩进级别
            diff = current_indent_level - indent_level
            if diff > 0:
                for _ in range(diff):
                    new_lines.append('   ')
                indent_level = current_indent_level
            elif diff < 0:
                for _ in range(-diff):
                    new_lines.pop()
                indent_level = current_indent_level
            new_lines.append('   ')
            line = line[len(current_indent):]
        new_lines.append(line)

    with open(file_path, 'w') as file:
        file.writelines(new_lines)

def process_directory(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_extension = os.path.splitext(file_path)[1]
            if file_extension in ['.c', '.cpp', '.py']:
                convert_indentation(file_path)

# 指定工程目录
project_directory = '/home/lihao/work/mesa'
process_directory(project_directory)
