#!/bin/bash

# 创建截图目录（如果不存在）
mkdir -p ~/图片/截图

# 生成文件名和完整路径
filename="截图 $(date +%Y-%m-%d' '%H-%M-%S).png"
filepath="$HOME/图片/截图/$filename"

# 执行截图
scrot "$filepath"

# 发送包含缩略图和路径的通知
dunstify -i "$filepath" "截图已保存" "文件路径: $filepath"