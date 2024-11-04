#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

case "$current_profile" in
    "balanced")
        echo "   Balanced "
        ;;
    "performance")
        echo "   Performance "
        ;;
    "power-saver")
        echo "   Power Saver "
        ;;
    *)
esac
