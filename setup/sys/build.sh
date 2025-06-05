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
    [[ "$service" == "ufw" ]] && sudo ufw enable
    sudo systemctl enable --now "$service"
    sudo systemctl start --now "$service"
    [[ "$service" == "ufw" ]] && sudo ufw status verbose
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
        read -rp "[::] info: remove it ? [y/N] " confirm
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
FONTS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/fonts.pkgs"
BASE_PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/base.pkgs"
POST_PKGS_FILE_PATH="/home/akileshas/.dotfiles/setup/sys/pkglist/post.pkgs"

## global functions
_init () {
    sudo -v

    local check_args=()
    local skip_sync=0

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --check-exclude )
                if [[ -z "$2" || "$2" == --* ]]; then
                    check_args+=( --exclude )
                    shift
                else
                    check_args+=( --exclude "$2" )
                    shift 2
                fi
                ;;
            --skip-sync )
                skip_sync=1
                shift
                ;;
            * )
                echo "[!!] error: unknown option '$1' !!!"
                echo
                exit 1
                ;;
        esac
    done

    _check "${check_args[@]}"

    if [[ $skip_sync -eq 0 ]]; then
        _sync
    else
        echo "[::] info: skipping system synchronization !!!"
        echo
    fi
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

_pre () {
    _init --check-exclude host

    echo
    echo "[#!](akileshas@ASA) info: preparing my system ..."

    echo
    echo "[::] info: creating directories ..."
    mkdir -p ~/personal \
            ~/work \
            ~/work/dev \
            ~/documents \
            ~/documents/books \
            ~/documents/papers \
            ~/downloads \
            ~/repos \
            ~/images \
            ~/images/screenshots \
            ~/videos \
            ~/videos/obs \
            ~/tmp
    echo "[::] info: creating directories ... done."
    echo

    echo
    echo "[::] info: creating files ..."
    touch ~/.bash_keys
    echo "[::] info: creating files ... done."
    echo

    echo "[#!](akileshas@ASA) info: preparing my system ... done. ;)"
    echo
}

_setup () {
    _init

    echo
    echo "[#!](akileshas@ASA) info: setting up my system ..."

    __install "$FONTS_FILE_PATH" "fonts"
    __install  "$BASE_PKGS_FILE_PATH" "base packages"
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

_post () {
    _init

    echo
    echo "[#!](akileshas@ASA) info: finalizing my system ..."

    __install "$POST_PKGS_FILE_PATH" "post packages"
    __activate "ufw"

    echo
    echo "[::] info: setting rust environment ..."
    rustup default stable
    rustup update
    echo "[::] info: setting rust environment ... done."
    echo

    echo "[#!](akileshas@ASA) info: finalizing my system ... done. ;)"
    echo
}

_main () {
    echo
    echo "[\$_] info: building the system ..."

    case "$1" in
        "" )
            _init
            ;;
        --init )
            shift
            _init "$@"
            ;;
        --sync )
            _sync
            shift
            ;;
        --check )
            shift
            _check "$@"
            ;;
        --pre )
            _pre
            shift
            ;;
        --setup )
            _setup
            shift
            ;;
        --post )
            _post
            shift
            ;;
        * )
            echo "[!!] error: unknown option '$1' !!!"
            echo
            exit 1
            ;;
    esac

    echo "[\$_] info: building the system ... done. [ʘ‿ʘ]"
    echo
}

## script entry
_main "$@"
