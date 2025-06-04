#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => my system (akileshas@ASA) setup script



## global variables
FONTS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/fonts.txt"
PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/pkgs.txt"

## global functions
_init () {
    if [[ -z $(command -v paru) ]]; then
        echo && echo "[!!] error: 'paru' is not installed !!!"
        exit 1
    fi

    echo && echo "[::] info: updating and synchronizing the system ..."
    sudo pacman -Syu --noconfirm
    paru -Syu --noconfirm
    echo "[::] info: updating and synchronizing the system ... done."

    sudo -v
}

_setup () {
    _init()

    echo && echo "[#!](akileshas@ASA) info: setting up my system ..."
    _install "$FONTS_FILE_PATH" "fonts"
    _install  "$PKGS_FILE_PATH" "packages"
    echo && echo "[#!](akileshas@ASA) info: setting up my system ... done. ;)"
}

_main () {}

## helper functions
_install () {
    local file_path="$1"
    local type="$2"

    if [[ ! -f "$file_path" ]]; then
        echo && echo "[~!] warn: skipping $type install — file not found: $file_path"
        return
    fi

    echo && echo "[::] info: installing ${type} ..."
    mapfile -t items < <(grep -vE "^\s*#|^\s*$" "$file_path")
    [[ ${#items[@]} -gt 0 ]] && paru -S --noconfirm "${items[@]}"
    [[ "$type" == "fonts" ]] && sudo fc-cache -fv
    echo "[::] info: installing ${type} ... done."
}
