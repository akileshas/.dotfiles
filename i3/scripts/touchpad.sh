#!/bin/bash

# Find the touchpad device ID
TOUCHPAD_ID=$(xinput list | grep -i "touchpad" | grep -o 'id=[0-9]*' | cut -d= -f2)

# Check if the touchpad ID was found
if [ -z "$TOUCHPAD_ID" ]; then
    echo "Touchpad not found."
    exit 1
fi

# Get the value of the 'Device Enabled' property
DEVICE_ENABLED=$(xinput list-props "$TOUCHPAD_ID" | grep "Device Enabled" | awk '{print $NF}')

# Output the current status
if [[ "$DEVICE_ENABLED" -eq 1 ]]; then
    echo ""
else
    echo " 󰂭 "
fi
