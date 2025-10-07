#!/bin/bash

# 依赖检查
if ! command -v jq &> /dev/null; then
    echo "错误：需要安装 jq 工具" >&2
    exit 1
fi

if ! command -v i3-msg &> /dev/null; then
    echo "错误：需要在 i3wm 环境中运行" >&2
    exit 1
fi

# 获取工作区状态的函数
get_workspace_status() {
    # 初始化10个工作区状态为 -1（未使用）
    status=(-1 -1 -1 -1 -1 -1 -1 -1 -1 -1)
    
    # 获取所有工作区信息
    workspaces=$(i3-msg -t get_workspaces)
    
    # 提取当前聚焦的工作区编号
    focused=$(echo "$workspaces" | jq -r '.[] | select(.focused==true) | .num')
    
    # 提取所有包含窗口的工作区编号
    occupied=$(echo "$workspaces" | jq -r '.[] | .num')
    
    # 更新聚焦工作区状态为 1
    if [[ -n "$focused" && "$focused" =~ ^[0-9]+$ ]] && ((focused >= 1 && focused <= 10)); then
        status[$((focused-1))]=1
    fi
    
    # 更新包含窗口的工作区状态为 0（跳过已标记为1的聚焦工作区）
    for ws in $occupied; do
        if [[ -n "$ws" && "$ws" =~ ^[0-9]+$ ]] && ((ws >= 1 && ws <= 10)); then
            idx=$((ws-1))
            [[ ${status[$idx]} -ne 1 ]] && status[$idx]=0
        fi
    done
    
    # 输出JSON格式的状态数组
    echo "[${status[@]}]" | tr ' ' ','
}

# 初始状态输出
get_workspace_status

# 监听工作区切换事件
i3-msg -t subscribe -m '["workspace"]' | while read -r event; do
    # 过滤掉不必要的事件（只处理焦点切换）
    if echo "$event" | jq -e '.change == "focus"' &>/dev/null; then
        get_workspace_status
    fi
done