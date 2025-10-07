#!/bin/bash

pkill -f "eww open-many"
sleep 0.2
nixGLIntel eww open-many bar top --config ~/.config/i3/eww
#eww open top --config ~/.config/i3/eww &