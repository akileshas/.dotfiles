#!/bin/bash

# Check if the host is ASA
if [ "$(hostnamectl hostname)" != "ASA" ]; then
    echo "This script is only intended to run on the host 'ASA'. Exiting."
    exit 1
fi

# Define the internal and external display names
INTERNAL="eDP-1"
EXTERNAL=$(xrandr | grep " connected" | grep -v "$INTERNAL" | cut -d " " -f1)

if [ -n "$EXTERNAL" ]; then
    # TO see the monitor config run `xrandr` command
    # External monitor is connected; set it to the right of the internal display
    xrandr --output "$INTERNAL" --mode 1920x1200 --primary --output "$EXTERNAL" --auto --right-of "$INTERNAL"
    feh --bg-fill ~/.dotfiles/i3/wallpaper/truth.png
else
    # Only internal monitor is connected; turn off other outputs
    xrandr --output "$INTERNAL" --auto --output "$EXTERNAL" --off
fi
