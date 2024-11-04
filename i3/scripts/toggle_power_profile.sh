#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Toggle between power-saver, balanced, and performance
case "$current_profile" in
    "power-saver")
        powerprofilesctl set balanced
        echo "  Balanced"
        ;;
    "balanced")
        powerprofilesctl set performance
        echo " Performance"
        ;;
    "performance")
        powerprofilesctl set power-saver
        echo "  Power Saver"
        ;;
    *)
        # Default to power-saver if an unknown profile is detected
        powerprofilesctl set power-saver
        echo "  Power Saver (default)"
        ;;
esac
