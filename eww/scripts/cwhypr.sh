#!/bin/bash
cd ~


LOCK_FILE="/tmp/i3_workspace_switch.lock"
exec 9>"$LOCK_FILE"
if ! flock -n 9; then
    exit 0
fi

hyprctl dispatch workspace $1
sleep 0.2