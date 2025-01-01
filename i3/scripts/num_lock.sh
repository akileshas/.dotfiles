#!/bin/bash

# Get the current Num Lock status using xset
num_status=$(xset q | grep "Num Lock" | awk '{print $8}')

# Check if Num Lock is on or off
if [ "$num_status" == "on" ]; then
    echo " N "
else
    echo ""
fi
