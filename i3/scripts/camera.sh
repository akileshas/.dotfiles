#!/bin/bash

# Check for camera devices
camera_device=$(ls /dev/video* 2>/dev/null)

if [ -n "$camera_device" ]; then
    # Check if the camera device is in use by any process
    if fuser $camera_device &>/dev/null; then
        echo "  "
    else
        echo ""
    fi
else
    echo "  "
fi
