#!/bin/bash
# Display current brightness level with specified icons using brightnessctl

# Get the current brightness level
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)

# Calculate brightness percentage
if [ "$max_brightness" -gt 0 ]; then
    brightness_percentage=$(( brightness * 100 / max_brightness ))
else
    brightness_percentage=0
fi

# Determine the icon based on the brightness level
if [ "$brightness_percentage" -ge 90 ]; then
    icon=" "  # Very Bright
elif [ "$brightness_percentage" -ge 70 ]; then
    icon=" "  # Bright
elif [ "$brightness_percentage" -ge 50 ]; then
    icon=" "  # Moderate
elif [ "$brightness_percentage" -ge 30 ]; then
    icon=" "  # Dim
elif [ "$brightness_percentage" -ge 10 ]; then
    icon=" "  # Very Dim
else
    icon=" "  # Off
fi

# Display the brightness level with the corresponding icon
echo " $icon$brightness_percentage% "
