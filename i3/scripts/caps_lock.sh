#!/bin/bash

# Get the current Caps Lock status using xset
caps_status=$(xset q | grep "Caps Lock" | awk '{print $4}')

# Check if Caps Lock is on or off
if [ "$caps_status" == "on" ]; then
    echo " "
else
    echo ""
fi
