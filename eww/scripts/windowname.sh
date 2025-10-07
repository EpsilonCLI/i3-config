#!/bin/bash

# 使用i3-msg订阅窗口事件，监听焦点变化
i3-msg -t subscribe -m '[ "window" ]' | while read -r event; do
    # 检查事件类型是否为窗口焦点变化
    if [[ $(echo "$event" | jq -r '.change') == "focus" ]]; then
        # 提取当前聚焦窗口的标题
        title=$(echo "$event" | jq -r '.container.name')
        # 若标题为空则显示未知窗口
        if [[ -z "$title" ]]; then
            echo ""
        else
            echo "$title"
        fi
    fi
done