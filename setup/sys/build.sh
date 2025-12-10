#!/usr/bin/env bash



#! author           => akileshas
#! created on       => 04-06-2025
#! last modified on => 07-08-2025
#! description      => my system (akileshas@asa) setup script



## helper functions
__activate () {
    local service="${1}"

    echo
    echo "[::] info: activating ${service} ..."
    [[ "${service}" == "bluetooth" ]] && sudo modprobe btusb
    [[ "${service}" == "ufw" ]] && sudo ufw enable
    sudo systemctl enable --now "${service}"
    sudo systemctl start --now "${service}"
    [[ "${service}" == "ufw" ]] && sudo ufw status verbose
    echo "[::] info: activating ${service} ... done."
    echo
}

__install () {
    local file_path="${1}"
    local type="${2}"

    if [[ ! -f "${file_path}" ]]; then
        echo
        echo "[!!] error: file not found: '${file_path}' !!!"
        echo "[!!] error: installing ${type} failed !!!"
        echo
        exit 1
    fi

    echo
    echo "[::] info: installing ${type} ..."
    mapfile -t items < <(grep -vE "^\s*#|^\s*$" "${file_path}")
    [[ ${#items[@]} -gt 0 ]] && yay -S --noconfirm "${items[@]}" || {
        echo "[!!] error: installing ${type} failed !!!"
        echo
        exit 1
    }
    [[ "${type}" == "fonts" ]] && sudo fc-cache -fv
    echo "[::] info: installing ${type} ... done."
    echo
}

__is_excluded () {
    local item="${1}"
    shift

    for excluded in "$@"; do
        [[ "${excluded}" == "${item}" ]] && return 0
    done

    return 1
}

__link () {
    local src="${1}"
    local dst="${2}"
    local type="${3}"

    echo
    echo "[::] info: linking '${dst##*/}' config ..."

    if [[ -L "${dst}" && "$(readlink "${dst}")" == "${src}" ]]; then
        echo "[::] info: skipped linking '${dst}' config - already linked !!!."
        echo
        return 0
    fi

    if [[ "${type}" == "dir" && -d "${dst}" ]] || [[ "${type}" == "file" && -f "${dst}" ]]; then
        echo "[~!] warn: '${dst}' config exists !!!"
        read -rp "[::] info: remove it ? [y/N] " confirm
        confirm="${confirm,,}"

        if [[ "${confirm}" == "y" || "${confirm}" == "yes" ]]; then
            rm -rf "${dst}"
            echo "[::] info: removed '${dst}' config !!!"
        else
            echo "[::] info: skipped linking '${dst##*/}' config !!!"
            echo
            return 0
        fi
    fi

    ln -s "${src}" "${dst}"

    echo "[::] info: linking '${dst##*/}' config ... done."
    echo
}

__ping () {
    local host="${1}"

    if ping -c 1 -W 1 "${host}" &> /dev/null; then
        echo "reached"
    else
        echo "unreached"
    fi
}

## global variables
HOST=$(hostnamectl hostname)
FONTS_FILE_PATH="${HOME}/.dotfiles/setup/sys/pkglist/fonts.pkgs"
BASE_PKGS_FILE_PATH="${HOME}/.dotfiles/setup/sys/pkglist/base.pkgs"
POST_PKGS_FILE_PATH="${HOME}/.dotfiles/setup/sys/pkglist/post.pkgs"

## global functions
_init () {
    sudo -v

    local check_args=()
    local skip_check=0
    local skip_sync=0

    while [[ $# -gt 0 ]]; do
        case "${1}" in
            --check-exclude=* )
                value="${1#--check-exclude=}"
                check_args+=("--exclude=${value}")
                shift
                ;;
            --skip-check )
                skip_check=1
                shift
                ;;
            --skip-sync )
                skip_sync=1
                shift
                ;;
            * )
                echo "[!!] error: unknown option '${1}' !!!"
                echo
                shift
                exit 1
                ;;
        esac
    done

    if [[ ${skip_check} -eq 0 ]]; then
        _check "${check_args[@]}"
    else
        echo
        echo "[::] info: skipping check !!!"
        [[ ${skip_sync} -eq 1 ]] && echo
    fi

    if [[ ${skip_sync} -eq 0 ]]; then
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
        case "${1}" in
            --exclude=* )
                value="${1#--exclude=}"
                if [[ -n "${value}" ]]; then
                    IFS=',' read -ra exclude_list <<< "${value}"
                else
                    exclude_list=()
                fi
                shift
                ;;
            * )
                echo "[!!] error: unknown option '${1}' !!!"
                echo
                shift
                exit 1
                ;;
        esac
    done

    if __is_excluded "yay" "${exclude_list[@]}"; then
        echo "[::](yay) check: excluded !!!"
    else
        if [[ -n $(command -v yay) ]]; then
            echo "[>>](yay) check: passed !!!"
        else
            echo "[>>](yay) check: failed !!!"
            echo "[!!] error: 'yay' is not installed !!!"
            echo
            exit 1
        fi
    fi

    if __is_excluded "host" "${exclude_list[@]}"; then
        echo "[::](host) check: excluded !!!"
    else
        if [[ "${HOST}" == "asa" ]]; then
            echo "[>>](host) check: passed !!!"
        else
            echo "[>>](host) check: failed !!!"
            echo "[!!] error: host must be 'asa' (got: '${HOST}') !!!"
            echo
            exit 1
        fi
    fi

    if __is_excluded "user" "${exclude_list[@]}"; then
        echo "[::](user) check: excluded !!!"
    else
        if [[ "${USER}" == "akileshas" ]]; then
            echo "[>>](user) check: passed !!!"
        else
            echo "[>>](user) check: failed !!!"
            echo "[!!] error: user must be 'akileshas' (got: '${USER}') !!!"
            echo
            exit 1
        fi
    fi

    if __is_excluded "ping" "${exclude_list[@]}"; then
        echo "[::](ping) check: excluded !!!"
    else
        if [[ $(__ping "archlinux.org") == "reached" ]]; then
            echo "[>>](ping) check: passed !!!"
        else
            echo "[>>](ping) check: failed !!!"
            echo "[!!] error: disconnected !!!"
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
    sudo pacman -Syyu --noconfirm
    yay -Syyu --noconfirm
    echo "[::] info: updating and synchronizing the system ... done."
    echo
}

_pre () {
    _init --check-exclude=yay,host --skip-sync

    echo
    echo "[#!](akileshas@asa) info: preparing my system ..."

    echo
    echo "[::] info: creating directories ..."
    mkdir -p ~/Desktop \
            ~/Documents \
            ~/Documents/Books \
            ~/Documents/Papers \
            ~/Documents/Vault \
            ~/Documents/Vault/Personal \
            ~/Documents/Vault/Work \
            ~/Downloads \
            ~/Music \
            ~/Music/Playlist \
            ~/Music/Track \
            ~/Pictures \
            ~/Pictures/Vault \
            ~/Pictures/Wallpaper \
            ~/Pictures/Screenshots \
            ~/Public \
            ~/Templates \
            ~/Videos \
            ~/Videos/OBS \
            ~/Videos/Man \
            ~/dev \
            ~/dev/env \
            ~/dev/repos \
            ~/dev/mirrors \
            ~/dev/orgs \
            ~/dev/orgs/deepomni \
            ~/dev/orgs/deepomni/repos \
            ~/dev/orgs/deepomni/forks \
            ~/dev/orgs/deepomni/mirrors \
            ~/dev/orgs/deepomni/tmp \
            ~/dev/orgs/pytorch \
            ~/dev/orgs/pytorch/repos \
            ~/dev/orgs/pytorch/forks \
            ~/dev/orgs/pytorch/mirrors \
            ~/dev/orgs/pytorch/tmp \
            ~/dev/orgs/tinygrad \
            ~/dev/orgs/tinygrad/repos \
            ~/dev/orgs/tinygrad/forks \
            ~/dev/orgs/tinygrad/mirrors \
            ~/dev/orgs/tinygrad/tmp \
            ~/dev/tmp
    echo "[::] info: creating directories ... done."
    echo

    echo
    echo "[::] info: creating files ..."
    echo "#!/usr/bin/env bash" > ~/.bash_keys
    echo "[::] info: creating files ... done."
    echo

    echo "[#!](akileshas@asa) info: preparing my system ... done. ;)"
    echo
}

_setup () {
    _init

    echo
    echo "[#!](akileshas@asa) info: setting up my system ..."

    __install "${FONTS_FILE_PATH}" "fonts"
    __install  "${BASE_PKGS_FILE_PATH}" "base packages"
    __activate "bluetooth"
    __activate "paccache.timer"
    __activate "power-profiles-daemon"

    __link ~/.dotfiles/i3 ~/.config/i3 "dir"
    __link ~/.dotfiles/kitty ~/.config/kitty "dir"
    __link ~/.dotfiles/lazygit ~/.config/lazygit "dir"
    __link ~/.dotfiles/mpv ~/.config/mpv "dir"
    __link ~/.dotfiles/rofi ~/.config/rofi "dir"
    __link ~/.dotfiles/starship ~/.config/starship "dir"
    __link ~/.dotfiles/warpd ~/.config/warpd "dir"
    __link ~/.dotfiles/bash/.profile ~/.profile "file"
    __link ~/.dotfiles/bash/.bashrc ~/.bashrc "file"
    __link ~/.dotfiles/bash/.bash_login ~/.bash_login "file"
    __link ~/.dotfiles/bash/.bash_logout ~/.bash_logout "file"
    __link ~/.dotfiles/bash/.bash_profile ~/.bash_profile "file"
    __link ~/.dotfiles/git/.gitconfig ~/.gitconfig "file"
    __link ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf "file"
    __link ~/.dotfiles/rtorrent/.rtorrent.rc ~/.rtorrent.rc "file"

    for v in 2.0 3.0 4.0; do
        __link ~/.dotfiles/gtk/gtk-${v} ~/.config/gtk-${v} "dir"
    done

    echo
    echo "[::] info: updating grub ..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "[::] info: updating grub ... done."
    echo

    echo "[#!](akileshas@asa) info: setting up my system ... done. ;)"
    echo
}

_post () {
    _init

    echo
    echo "[#!](akileshas@asa) info: finalizing my system ..."

    __install "${POST_PKGS_FILE_PATH}" "post packages"
    __activate "ufw"

    echo
    echo "[::] info: setting rust environment ..."
    rustup default nightly
    rustup update
    echo "[::] info: setting rust environment ... done."
    echo

    echo "[#!](akileshas@asa) info: finalizing my system ... done. ;)"
    echo
}

_usage () {
    echo
    echo "'akileshas@asa' system setup script"
    echo
    echo "usage:"
    echo "  bash ./build.sh [options]"
    echo "  bash ./build.sh [command] [options]"
    echo
    echo "commands:"
    echo "  init [options]              initialize system (runs checks and optionally syncs)."
    echo "      --check-exclude=items   exclude checks (comma-separated: yay,user,host)."
    echo "      --skip-check            skip checks step."
    echo "      --skip-sync             skip system sync step."
    echo "  check [options]             run pre-flight checks (yay, user, host, ping)."
    echo "      --exclude=items         exclude checks (comma-separated: yay,user,host)."
    echo "  sync                        sync system time and update mirrors/packages."
    echo "  pre                         pre-install setup (e.g. enabling services)."
    echo "  setup                       run main setup logic (install packages, fonts, link dotfiles)."
    echo "  post                        post-setup steps (e.g. enable services, cleanup)."
    echo
    echo "options:"
    echo "  -h, --help                  show help message."
    echo
}

_main () {
    case "${1}" in
        --help | -h )
            _usage
            shift
            exit 0
            ;;
    esac

    echo
    echo "[\$_] info: building the system ..."

    case "${1}" in
        "" )
            _init
            exit 0
            ;;
        init )
            shift
            _init "$@"
            exit 0
            ;;
        sync )
            _sync
            shift
            exit 0
            ;;
        check )
            shift
            _check "$@"
            exit 0
            ;;
        pre )
            _pre
            shift
            exit 0
            ;;
        setup )
            _setup
            shift
            exit 0
            ;;
        post )
            _post
            shift
            exit 0
            ;;
        * )
            echo "[!!] error: unknown option '${1}' !!!"
            echo
            shift
            exit 1
            ;;
    esac

    echo "[\$_] info: building the system ... done. [ʘ‿ʘ]"
    echo
}


_main "$@"
