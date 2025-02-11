#!/bin/bash

# 定义文件夹路径，当前目录
FOLDER="/home/ruttan/桌面/新建文件夹"

# 遍历文件夹中的所有 JPG 文件
for file in "$FOLDER"/*.jpg; do
    if [ -f "$file" ]; then
        # 使用 ImageMagick 的 convert 命令修复文件
        convert "$file" "$file"
        echo "已修复：$file"
    fi
done

echo "所有文件已处理完成！"
