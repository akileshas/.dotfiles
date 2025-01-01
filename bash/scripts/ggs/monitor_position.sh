#!/bin/bash

# Check if the host is GGS
if [ "$(hostnamectl hostname)" != "GGS" ]; then
    echo "This script is only intended to run on the host 'GGS'. Exiting."
    exit 1
fi

# Define the internal and external display names
INTERNAL="eDP"
EXTERNAL=$(xrandr | grep " connected" | grep -v "$INTERNAL" | cut -d " " -f1)

# Check if the external monitor is connected
if [ -z "$EXTERNAL" ]; then
    echo "No external monitor connected."
    exit 1
fi

# Use fzf to prompt the user for the desired configuration
CHOICE=$(echo -e "Right of the internal monitor\nLeft of the internal monitor\nDuplicate the internal monitor\nDisconnect the external monitor" | fzf --prompt="Choose monitor configuration: " --layout=reverse --height=10%)

# Apply the chosen configuration
case $CHOICE in
    "Right of the internal monitor")
        xrandr --output "$INTERNAL" --mode 1920x1080 --primary \
               --output "$EXTERNAL" --auto --right-of "$INTERNAL"
        ;;
    "Left of the internal monitor")
        xrandr --output "$INTERNAL" --mode 1920x1080 --primary \
               --output "$EXTERNAL" --auto --left-of "$INTERNAL"
        ;;
    "Duplicate the internal monitor")
        xrandr --output "$INTERNAL" --mode 1920x1080 --primary \
               --output "$EXTERNAL" --auto --same-as "$INTERNAL"
        ;;
    "Disconnect the external monitor")
        xrandr --output "$EXTERNAL" --off
        ;;
    *)
        echo "Invalid choice or cancelled. Exiting."
        exit 1
        ;;
esac

# Optionally set a wallpaper for the monitors
feh --bg-fill ~/.dotfiles/i3/wallpaper/truth.png

echo "Configuration applied."
