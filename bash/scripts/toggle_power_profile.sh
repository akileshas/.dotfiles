#!/bin/bash

# Check if powerprofilesctl is installed
if ! command -v powerprofilesctl &>/dev/null; then
    echo "powerprofilesctl is not installed. Please install it to continue."
    exit 1
fi

# Define the available power profiles
options=("  Power Saver" "  Balanced" "  Performance")

# Use fzf to select the desired profile
choice=$(printf "%s\n" "${options[@]}" | fzf --prompt="Select Power Profile: " --layout=reverse --height=10%)

# Check the user's selection and apply the corresponding profile
case "$choice" in
"  Power Saver")
    powerprofilesctl set power-saver
    echo "  Power Saver"
    ;;
"  Balanced")
    powerprofilesctl set balanced
    echo "  Balanced"
    ;;
"  Performance")
    powerprofilesctl set performance
    echo " Performance"
    ;;
*)
    echo "No selection made or invalid option. Exiting."
    exit 1
    ;;
esac
