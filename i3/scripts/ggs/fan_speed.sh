#!/bin/bash

# Use sensors to get fan speeds
FAN=$(sensors | grep -m1 'Fan' | awk '{print $3}')

# Check if fan speeds were detected
if [ -z "$FAN" ]; then
    FAN1="N/A"
fi

# Output fan speeds in a compact format with separator
echo " 󰈐  $FAN RPM "
