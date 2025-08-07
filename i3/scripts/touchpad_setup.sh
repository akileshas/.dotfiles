#!/bin/bash

# Get the static hostname
HOSTNAME=$(hostnamectl --static)

if [ "$HOSTNAME" = "asa" ]; then
    xinput set-prop "PIXA3848:00 093A:3848 Touchpad" "libinput Tapping Enabled" 1
    xinput set-prop "PIXA3848:00 093A:3848 Touchpad" "libinput Natural Scrolling Enabled" 1
fi
