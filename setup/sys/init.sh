#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => my system (akileshas@ASA) setup script



## declaring the global variables
FILE_PATH="/home/$USER/.dotfiles/setup/sys/pkglist/pkgs.txt"

## obtaining `sudo` privileges access
sudo -v

## starting the installation script
echo && echo "[#!](akileshas@ASA) setting up my system ..."

## checking if `paru` is installed
if [[ -z $(command -v paru) ]]; then
    echo && echo "[!!] error: 'paru' is not installed !!!"
    exit 1
fi

## updating and synchronizing the system
echo && echo "[::] updating and synchronizing the system ..."
sudo pacman -Syu --noconfirm
paru -Syu --noconfirm
echo "[::] updating and synchronizing the system ... done."

## installing the required packages
if [[ -f "$FILE_PATH" ]]; then
    echo && echo "[::] installing the required packages ..."
    mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$FILE_PATH")
    if [[ ${#pkgs[@]} -gt 0 ]]; then
        paru -S --noconfirm "${pkgs[@]}"
    fi
    echo "[::] installing the required packages ... done."
fi

echo && echo "[#!](akileshas@ASA) setting up my system ... done. ;)"
