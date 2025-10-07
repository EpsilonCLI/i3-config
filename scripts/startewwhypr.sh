#!/bin/bash

pkill -f "eww open-many"
sleep 0.2
eww open-many bar top --config ~/.config/i3/eww-hypr
#eww open top --config ~/.config/i3/eww-button &
#eww update workspacescroll="if [ {} = \"up\" ]; then /home/epsilon/.config/i3/scripts/cwhypr.sh -1 ; else /home/epsilon/.config/i3/scripts/cwhypr.sh +1 ; fi" --config ~/.config/i3/eww-button

