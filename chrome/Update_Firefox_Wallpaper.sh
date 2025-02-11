#!/bin/bash

# 获取当前桌面背景路径
bg_path=$(gsettings get org.gnome.desktop.background picture-uri | sed "s/'//g" | sed 's/^file:\/\///')

# 设置 chrome_folder 文件的路径
chrome_folder="/home/ruttan/.mozilla/firefox/uvc897fj.default-esr/chrome"

# 获取文件夹中的所有 .jpg 图片并删除
echo "删除 $chrome_folder 文件夹中的所有 .jpg 图片..."
find "$chrome_folder" -type f -name "*.jpg" -exec rm -f {} \;

# 将当前桌面背景复制到该文件夹，并将文件名改为 1.jpg
echo "复制当前桌面背景到 $chrome_folder 文件夹并重命名为 1.jpg..."
cp "$bg_path" "$chrome_folder/1.jpg"

# 设置定时执行上述脚本：0 0 * * * /home/ruttan/shell_script/Update_Firefox_Wallpaper.sh
