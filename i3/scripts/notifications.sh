#!/bin/bash

# Run each script and capture its output
caps_lock=$(~/.dotfiles/i3/scripts/caps_lock.sh)
num_lock=$(~/.dotfiles/i3/scripts/num_lock.sh)
mic=$(~/.dotfiles/i3/scripts/microphone.sh)
flight_mode=$(~/.dotfiles/i3/scripts/flight_mode.sh)
current_power_profile=$(~/.dotfiles/i3/scripts/current_power_profile.sh)

# Combine all outputs into a single line
echo "$caps_lock$num_lock$mic$flight_mode$current_power_profile"
