#!/bin/bash
# Display current volume level and mute status using pamixer

# Get volume level and mute status
volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

# Display volume with icon based on mute status
if [ "$mute" = "true" ]; then
    echo " "
else
    if [ "$volume" -ge 80 ]; then
        icon=" " # Loud
    elif [ "$volume" -ge 40 ]; then
        icon=" " # Medium
    else
        icon=" " # Quiet
    fi
    echo " $icon $volume% "
fi
