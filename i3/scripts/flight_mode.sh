#!/bin/bash

# Check if any Wi-Fi device is soft-blocked
wifi_status=$(rfkill list wlan | grep -i "Soft blocked" | awk '{print $3}')

# Check if any Bluetooth device is soft-blocked
bluetooth_status=$(rfkill list bluetooth | grep -i "Soft blocked" | awk '{print $3}')

# Check if either Wi-Fi or Bluetooth has a 'yes' for soft block
if echo "$wifi_status" | grep -q "yes" || echo "$bluetooth_status" | grep -q "yes"; then
    echo " F "
else
    echo ""
fi
