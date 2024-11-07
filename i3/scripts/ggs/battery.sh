#!/bin/bash
# Display battery percentage and charging status

# Get battery percentage and status
status=$(cat /sys/class/power_supply/BAT0/status)
capacity=$(cat /sys/class/power_supply/BAT0/capacity)

# Display percentage with charging status icon
if [ "$status" = "Charging" ]; then
    echo "  $capacity% "
elif [ "$status" = "Full" ]; then
    echo " 󰁹 $capacity% "
else
    if [ "$capacity" -ge 80 ]; then
        icon="󰂂"
    elif [ "$capacity" -ge 60 ]; then
        icon="󰂀"
    elif [ "$capacity" -ge 40 ]; then
        icon="󰁾"
    elif [ "$capacity" -ge 20 ]; then
        icon="󰁼"
    else
        icon="󰁻"
    fi
    echo " $icon $capacity% "
fi
