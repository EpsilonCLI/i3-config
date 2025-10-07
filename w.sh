#!/bin/bash
cd ~


LOCK_FILE="/tmp/i3_workspace_switch.lock"
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
    exit 0
fi

# Set the current workspace (replace with your method to get the current workspace)
current_workspace=$(xdotool get_desktop)
target_workspace=$1  # Pass target workspace as an argument to the script
sss=$((target_workspace + 1))
zzz=$2

# Determine if switching up or down
if [[ $target_workspace -gt $current_workspace ]]; then
    # Switching to a higher-numbered workspace
    current_switch_value=1
    target_switch_value=2
else
    # Switching to a lower-numbered workspace
    current_switch_value=2
    target_switch_value=1
fi

# Get windows in the current workspace
current_windows=$(wmctrl -l | awk -v ws="$current_workspace" '$2 == ws {print $1}')
# Get windows in the target workspace
target_windows=$(wmctrl -l | awk -v ws="$target_workspace" '$2 == ws {print $1}')

# Apply _MY_CUSTOM_WORKSPACE_SWITCH to current workspace windows
for win in $current_windows; do
    xprop -id "$win" -f _MY_CUSTOM_WORKSPACE_SWITCH 32i -set _MY_CUSTOM_WORKSPACE_SWITCH $current_switch_value
done

# Apply _MY_CUSTOM_WORKSPACE_SWITCH to target workspace windows
for win in $target_windows; do
    xprop -id "$win" -f _MY_CUSTOM_WORKSPACE_SWITCH 32i -set _MY_CUSTOM_WORKSPACE_SWITCH $target_switch_value
done

# Switch to the target workspace
sleep 0.03
xdotool set_desktop "$target_workspace"
if [[ 3 -gt $zzz ]]; then
    i3-msg "workspace number $sss"
fi
sleep 0.12
# Clean up: Remove _MY_CUSTOM_WORKSPACE_SWITCH from all windows



# 获取所有工作区状态
workspaces=$(i3-msg -t get_workspaces)
   
# 更新每个工作区的eww状态



all_windows=$(wmctrl -l | awk '{print $1}')
for win in $all_windows; do
    xprop -id "$win" -remove _MY_CUSTOM_WORKSPACE_SWITCH
done
