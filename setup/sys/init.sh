#!/bin/bash



#! autor            => akileshas
#! created on       => 04-06-2025
#! last modified on => 04-06-2025
#! description      => my system (akileshas@ASA) setup script



## global variables
HOST=$(hostnamectl hostname)
FONTS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/fonts.txt"
PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/pkgs.txt"

## global functions
_init () {
    _check

    echo && echo "[::] info: updating and synchronizing the system ..."
    sudo pacman -Syu --noconfirm
    paru -Syu --noconfirm
    echo "[::] info: updating and synchronizing the system ... done."

    sudo -v
}

_check () {
    echo && echo "[::] checking requirements ..."

    if [[ -n $(command -v paru) ]]; then
        echo "[>>](paru) check: passed !!!"
    else
        echo "[>>](paru) check: failed !!!"
        echo && echo "[!!] error: 'paru' is not installed !!!"
        exit 1
    fi

    if [[ "$USER" == "akileshas" ]]; then
        echo "[>>](user) check: passed !!!"
    else
        echo "[>>](user) check: failed !!!"
        echo && echo "[!!] error: user must be 'akileshas' (got: '$USER')"
        exit 1
    fi

    if [[ "$HOST" == "ASA" ]]; then
        echo "[>>](host) check: passed !!!"
    else
        echo "[>>](host) check: failed !!!"
        echo && echo "[!!] error: host must be 'ASA' (got: '$HOST')"
        exit 1
    fi

    echo "[::] info: checking requirements ... done."
}

_setup () {
    _init

    echo && echo "[#!](akileshas@ASA) info: setting up my system ..."
    _install "$FONTS_FILE_PATH" "fonts"
    _install  "$PKGS_FILE_PATH" "packages"
    echo && echo "[#!](akileshas@ASA) info: setting up my system ... done. ;)"
}

_main () {
    case "$1" in
        "" )
            _init
            ;;
        --init )
            _init
            ;;
        --check )
            _check
            ;;
        --setup )
            _setup
            ;;
    esac
}

## helper functions
_install () {
    local file_path="$1"
    local type="$2"

    if [[ ! -f "$file_path" ]]; then
        echo && echo "[~!] warn: skipping $type install — file not found: $file_path !!!"
        return
    fi

    echo && echo "[::] info: installing ${type} ..."
    mapfile -t items < <(grep -vE "^\s*#|^\s*$" "$file_path")
    [[ ${#items[@]} -gt 0 ]] && paru -S --noconfirm "${items[@]}"
    [[ "$type" == "fonts" ]] && sudo fc-cache -fv
    echo "[::] info: installing ${type} ... done."
}

## script entry
_main "$@"
