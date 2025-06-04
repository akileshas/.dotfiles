#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => system ( archlinux + i3wm + x11 ) setup script



# obtaining `sudo` privileges access
sudo -v

# starting the installation script
echo && echo "[#!](akileshas@ASA) setting up my system ..."

# checking if `paru` is installed
if ! command -v paru &> /dev/null; then
    echo && echo "[!!] error: 'paru' is not installed !!!"
    exit 1
fi

# updating and synchronizing the system
echo && echo "[::] updating and synchronizing the system ..."
sudo pacman -Syu --noconfirm
paru -Syu --noconfirm
echo "[::] updating and synchronizing the system ... done."

echo
echo "[#!](akileshas@ASA) setting up my system ... done. ;)"
