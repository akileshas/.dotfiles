#!/bin/bash

# Check if the host is asa
if [ "$(hostnamectl hostname)" != "asa" ]; then
    echo "This script is only intended to run on the host 'asa'. Exiting."
    exit 1
fi

# Define the internal and external display names
INTERNAL="eDP-1"
EXTERNAL=$(xrandr | grep " connected" | grep -v "$INTERNAL" | cut -d " " -f1)

if [ -n "$EXTERNAL" ]; then
    # External monitor is connected; set it to the right of the internal display
    xrandr --output "$INTERNAL" --mode 1920x1200 --primary --output "$EXTERNAL" --auto --left-of "$INTERNAL"
    feh --bg-fill ~/.dotfiles/i3/wallpaper/hi.png
else
    # Only internal monitor is connected
    xrandr --output "$INTERNAL" --auto

    # Optionally turn off known external outputs explicitly
    for OUT in HDMI-1-0 DP-1-0 DP-1-1 DP-1-2 DP-1-3 DP-1-4; do
        xrandr --output "$OUT" --off
    done
fi
