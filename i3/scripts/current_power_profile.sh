#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

case "$current_profile" in
    "balanced")
        echo "  "
        ;;
    "performance")
        echo "  "
        ;;
    "power-saver")
        echo "  "
        ;;
    *)
esac
