#!/bin/bash

# Lock the screen
if [ "$(hostnamectl hostname)" = "GGS" ]; then
    i3lock -i ~/.dotfiles/pictures/fuck-society.png -c 000000
fi

# Suspend the system
systemctl suspend
