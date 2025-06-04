#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => my system (akileshas@ASA) setup script



## declaring the global variables
FONTS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/fonts.txt"
PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/pkgs.txt"

## helper functions
_install() {
    local file_path="$1"
    local type="$2"

    [[ -f "$file_path" ]] || return

    echo && echo "[::] installing ${type} ..."
    mapfile -t items < <(grep -vE "^\s*#|^\s*$" "$file_path")
    [[ ${#items[@]} -gt 0 ]] && paru -S --noconfirm "${items[@]}"
    [[ "$type" == "fonts" ]] && sudo fc-cache -fv
    echo "[::] installing ${type} ... done."
}

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
_install "$FONTS_FILE_PATH" "fonts"

## installing the required packages
_install  "$PKGS_FILE_PATH" "packages"

echo && echo "[#!](akileshas@ASA) setting up my system ... done. ;)"
