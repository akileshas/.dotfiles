#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => my system (akileshas@ASA) setup script



## declaring the global variables
FONTS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/fonts.txt"
PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/pkgs.txt"

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

## installing the required fonts
if [[ -f "$FONTS_FILE_PATH" ]]; then
    echo && echo "[::] installing the required fonts ..."
    mapfile -t fonts < <(grep -vE '^\s*#|^\s*$' "$FONTS_FILE_PATH")
    if [[ ${#fonts[@]} -gt 0 ]]; then
        paru -S --noconfirm "${fonts[@]}"
    fi
    sudo fc-cache -fv
    echo "[::] installing the required fonts ... done."
fi

## installing the required packages
if [[ -f "$PKGS_FILE_PATH" ]]; then
    echo && echo "[::] installing the required packages ..."
    mapfile -t pkgs < <(grep -vE '^\s*#|^\s*$' "$PKGS_FILE_PATH")
    if [[ ${#pkgs[@]} -gt 0 ]]; then
        paru -S --noconfirm "${pkgs[@]}"
    fi
    echo "[::] installing the required packages ... done."
fi

echo && echo "[#!](akileshas@ASA) setting up my system ... done. ;)"
