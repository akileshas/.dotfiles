#!/bin/bash

# Run each script and capture its output
camera=$(~/dev/env/.dotfiles/i3/scripts/camera.sh)
touchpad=$(~/dev/env/.dotfiles/i3/scripts/touchpad.sh)
caps_lock=$(~/dev/env/.dotfiles/i3/scripts/caps_lock.sh)
num_lock=$(~/dev/env/.dotfiles/i3/scripts/num_lock.sh)
mic=$(~/dev/env/.dotfiles/i3/scripts/microphone.sh)
flight_mode=$(~/dev/env/.dotfiles/i3/scripts/flight_mode.sh)
current_power_profile=$(~/dev/env/.dotfiles/i3/scripts/current_power_profile.sh)

# Combine all outputs into a single line
echo "$camera$touchpad$caps_lock$num_lock$mic$flight_mode$current_power_profile"
