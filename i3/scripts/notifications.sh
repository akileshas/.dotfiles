#!/bin/bash

# Run each script and capture its output
mic=$(~/.dotfiles/i3/scripts/microphone.sh)
current_power=$(~/.dotfiles/i3/scripts/current_power_profile.sh)
caps_lock=$(~/.dotfiles/i3/scripts/caps_lock.sh)
num_lock=$(~/.dotfiles/i3/scripts/num_lock.sh)
flight_mode=$(~/.dotfiles/i3/scripts/flight_mode.sh)

# Combine all outputs into a single line
echo "$mic$current_power$caps_lock$num_lock$flight_mode"
