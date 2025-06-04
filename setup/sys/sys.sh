#!/bin/bash



#! author           => akileshas
#! created on       => 04-06-2025
#! last modified on => 05-06-2025
#! description      => my system (akileshas@ASA) setup script



## helper functions
__install () {
    local file_path="$1"
    local type="$2"

    if [[ ! -f "$file_path" ]]; then
        echo
        echo "[~!] warn: skipping $type install — file not found: '$file_path' !!!"
        echo
        return
    fi

    echo
    echo "[::] info: installing ${type} ..."
    mapfile -t items < <(grep -vE "^\s*#|^\s*$" "$file_path")
    [[ ${#items[@]} -gt 0 ]] && paru -S --noconfirm "${items[@]}"
    [[ "$type" == "fonts" ]] && sudo fc-cache -fv
    echo "[::] info: installing ${type} ... done."
    echo
}

__activate () {
    local service="$1"

    echo
    echo "[::] info: activating $service ..."
    [[ "$service" == "bluetooth" ]] && sudo modprobe btusb
    sudo systemctl enable --now "$service"
    sudo systemctl start --now "$service"
    echo "[::] info: activating $service ... done."
    echo
}

__link () {
    local src="$1"
    local dst="$2"
    local type="$3"

    echo
    echo "[::] info: linking '${dst##*/}' config ..."

    if [[ "$type" == "dir" && -d "$dst" ]] || [[ "$type" == "file" && -f "$dst" ]]; then
        echo "[~!] warn: '${dst}' exists !!!"
        read -p "[::] info: remove it ? [y/N] " confirm
        confirm="${confirm,,}"

        if [[ "$confirm" == "y" || "$confirm" == "yes" ]]; then
            rm -rf "$dst"
            echo "[::] info: removed '${dst}' !!!"
        else
            echo "[::] info: skipped linking '${dst##*/}' config !!!"
            echo
            return
        fi
    fi

    ln -s "$src" "$dst"

    echo "[::] info: linking ${dst##*/} ... done."
    echo
}

__is_excluded () {
    local item="$1"
    shift

    for excluded in "$@"; do
        [[ "$excluded" == "$item" ]] && return 0
    done

    return 1
}

## global variables
HOST=$(hostnamectl hostname)
FONTS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/fonts.txt"
PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/pkgs.txt"

## global functions
_init () {
    sudo -v

    _check
    _sync
}

_check () {
    echo
    echo "[::] info: checking requirements ..."

    local exclude_list=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --exclude )
                if [[ -z "$2" || "$2" == --* ]]; then
                    exclude_list=()
                    shift
                else
                    IFS=',' read -ra exclude_list <<< "$2"
                    shift 2
                fi
                ;;
            * )
                echo "[!!] error: unknown option '$1' !!!"
                echo
                exit 1
                ;;
        esac
    done

    if __is_excluded "paru" "${exclude_list[@]}"; then
        echo "[::](paru) check: excluded !!!"
    else
        if [[ -n $(command -v paru) ]]; then
            echo "[>>](paru) check: passed !!!"
        else
            echo "[>>](paru) check: failed !!!"
            echo "[!!] error: 'paru' is not installed !!!"
            echo
            exit 1
        fi
    fi

    if __is_excluded "user" "${exclude_list[@]}"; then
        echo "[::](user) check: excluded !!!"
    else
        if [[ "$USER" == "akileshas" ]]; then
            echo "[>>](user) check: passed !!!"
        else
            echo "[>>](user) check: failed !!!"
            echo "[!!] error: user must be 'akileshas' (got: '$USER') !!!"
            echo
            exit 1
        fi
    fi

    if __is_excluded "host" "${exclude_list[@]}"; then
        echo "[::](host) check: excluded !!!"
    else
        if [[ "$HOST" == "ASA" ]]; then
            echo "[>>](host) check: passed !!!"
        else
            echo "[>>](host) check: failed !!!"
            echo "[!!] error: host must be 'ASA' (got: '$HOST') !!!"
            echo
            exit 1
        fi
    fi

    echo "[::] info: checking requirements ... done."
    echo
}

_sync () {
    echo
    echo "[::] info: updating and synchronizing the system ..."
    sudo pacman -Syu --noconfirm
    paru -Syu --noconfirm
    echo "[::] info: updating and synchronizing the system ... done."
    echo
}

_setup () {
    _init

    echo
    echo "[#!](akileshas@ASA) info: setting up my system ..."

    __install "$FONTS_FILE_PATH" "fonts"
    __install  "$PKGS_FILE_PATH" "packages"
    __activate "bluetooth"
    __activate "paccache.timer"

    echo
    echo "[::] info: updating grub ..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "[::] info: updating grub ... done."
    echo

    __link ~/.dotfiles/i3 ~/.config/i3 "dir"
    __link ~/.dotfiles/kitty ~/.config/kitty "dir"
    __link ~/.dotfiles/lazygit ~/.config/lazygit "dir"
    __link ~/.dotfiles/rofi ~/.config/rofi "dir"
    __link ~/.dotfiles/starship ~/.config/starship "dir"
    __link ~/.dotfiles/bash/.bashrc ~/.bashrc "file"
    __link ~/.dotfiles/bash/.bash_logout ~/.bash_logout "file"
    __link ~/.dotfiles/bash/.bash_profile ~/.bash_profile "file"
    __link ~/.dotfiles/git/.gitconfig ~/.gitconfig "file"
    __link ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf "file"

    for v in 2.0 3.0 4.0; do
        __link ~/.dotfiles/gtk/gtk-$v ~/.config/gtk-$v "dir"
    done

    echo "[#!](akileshas@ASA) info: setting up my system ... done. ;)"
    echo
}

_main () {
    case "$1" in
        "" )
            _init
            ;;
        --init )
            _init
            ;;
        --sync )
            _sync
            ;;
        --check )
            _check
            ;;
        --setup )
            _setup
            ;;
        * )
            echo "[!!] error: unknown option '$1' !!!"
            echo
            exit 1
            ;;
    esac
}

## script entry
_main "$@"
