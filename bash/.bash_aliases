#!/bin/bash

#################################################
#                 BASH ALIASES                  #
#################################################

# Rectify the last command with sudo
alias wtf='sudo $(history -p !!)'

# Correct the last mistake command
alias fk="fuck"

# Updating and Cleaning the packages
alias upd="sudo pacman -Syu && paru -Syu"
alias fupd="sudo pacman -Syyu && paru -Syyu"
alias cln="sudo pacman -Sc && sudo pacman -Scc && paru -Sc && paru -Scc && sudo journalctl --vacuum-size=100M"

# Jumping to up directory
alias rt="cd /"
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# Editor aliases
alias v="nvim"
alias sv="sudo nvim"
alias code="code-insiders"

# Exit the terminal
alias x="exit"

# Clear the terminal
alias cls="clear"

# Logout
alias logout="pkill -KILL -u $USER"
alias boom="pkill -KILL -u $USER"

# Reboot the system
alias rb="sudo reboot"
alias srb="sudo systemctl reboot"
alias miss-you="sudo reboot"

# Shutdown the system
alias shit="sudo shutdown -h now"
alias bye="sudo shutdown -h now"

# Alias for the Mirrors
alias ls-mir="bat /etc/pacman.d/mirrorlist"
alias upd-mir="sudo reflector --verbose --latest 11 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

# Aliases for managing orphan packages
alias ls-orph="sudo pacman -Qdt"
alias cls-orph="pacman -Qdqt | sudo pacman -Rns -"

# Bouncing the swap memory
# Used to refresh, clean and troubleshoot the swap memory
# alias bounce_swap='sudo swapoff -a && sleep 10 && sudo swapon -a'

# Cleaning the cache memory
alias cls-cache="echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null"

# MySQL Path
alias mysql="/usr/bin/mariadb -u asa -p"

# Switching the Power Profile
alias chpp="~/.dotfiles/bash/scripts/toggle_power_profile.sh"

# Switching the Monitor Position
alias chmp="~/.dotfiles/bash/scripts/monitor_position.sh"

# Load the LazyGit
alias lg="lazygit"

# Load the LazyDocker
alias ld="lazydocker"

# For the fortune
alias fortune="/usr/bin/fortune | cowsay | lolcat"

# Set a alias for Bastard Operator From Hell (bofh)
alias bofh="/usr/bin/fortune bofh-excuses | cowsay | lolcat"

# Alias for history
alias hst="history | bat"

# Alias to open any file in Hexdump
# alias hexread="function _hexread(){ hexdump -C '$1' | nvim; }; _hexread"

# Copy and Paste aliases
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"

# Current time
alias now="date '+%Y-%m-%d %A %I:%M:%S %p %Z'"

# Reload the bash configuration
alias rbrc="source ~/.dotfiles/bash/.bashrc"
alias rbpf="source ~/.dotfiles/bash/.bash_profile"
alias rblo="source ~/.dotfiles/bash/.bash_logout"
alias rbal="source ~/.dotfiles/bash/.bash_aliases"
alias rbfn="source ~/.dotfiles/bash/.bash_functions"
alias rbexp="source ~/.dotfiles/bash/.bash_exports"
alias rbvar="source ~/.dotfiles/bash/.bash_variables"
alias rbkey="source ~/.bash_keys"

# Edit the bash configuration
alias ebrc="nvim ~/.dotfiles/bash/.bashrc"
alias ebpf="nvim ~/.dotfiles/bash/.bash_profile"
alias eblo="nvim ~/.dotfiles/bash/.bash_logout"
alias ebal="nvim ~/.dotfiles/bash/.bash_aliases"
alias ebfn="nvim ~/.dotfiles/bash/.bash_functions"
alias ebexp="nvim ~/.dotfiles/bash/.bash_exports"
alias ebvar="nvim ~/.dotfiles/bash/.bash_variables"
alias ebkey="nvim ~/.bash_keys"

# Alert for long running commands
alias alert='
if [ $? -eq 0 ]; then
    notify-send --urgency=critical -i terminal "✔ Command Succeeded" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'' )";
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
else
    i3-nagbar -m "✖ Command Failed: $(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'' )";
    paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga;
fi
'

# alias chmod commands
alias cpmx='chmod a+x'
alias cp000='chmod -R 000'
alias cp644='chmod -R 644'
alias cp666='chmod -R 666'
alias cp755='chmod -R 755'
alias cp777='chmod -R 777'

# Extracting the compressed files
alias extract="atool"

# Pacman aliases
alias pac="sudo pacman"
alias pacs="sudo pacman -S"
alias pacss="sudo pacman -Ss"
alias pacsss="sudo pacman -Sss"
alias pacsw="sudo pacman -Sw"
alias pacsy="sudo pacman -Sy"
alias pacsyy="sudo pacman -Syy"
alias pacsu="sudo pacman -Su"
alias pacsyu="sudo pacman -Syu"
alias pacsyyu="sudo pacman -Syyu"
alias pacsd="sudo pacman -Sd"
alias pacsdd="sudo pacman -Sdd"
alias pacsg="sudo pacman -Sg"
alias pacsc="sudo pacman -Sc"
alias pacscc="sudo pacman -Scc"
alias pacsi="sudo pacman -Si"
alias pacsii="sudo pacman -Sii"
alias pacr="sudo pacman -R"
alias pacrc="sudo pacman -Rc"
alias pacrs="sudo pacman -Rs"
alias pacrn="sudo pacman -Rn"
alias pacrd="sudo pacman -Rd"
alias pacrns="sudo pacman -Rns"
alias pacrnn="sudo pacman -Rnn"
alias pacrdd="sudo pacman -Rdd"
alias pacq="sudo pacman -Q"
alias pacqe="sudo pacman -Qe"
alias pacql="sudo pacman -Ql"
alias pacqi="sudo pacman -Qi"
alias pacqs="sudo pacman -Qs"
alias pacqo="sudo pacman -Qo"
alias pacqu="sudo pacman -Qu"
alias pacqg="sudo pacman -Qg"
alias pacqm="sudo pacman -Qm"
alias pacqk="sudo pacman -Qk"
alias pacqr="sudo pacman -Qr"
alias pacqd="sudo pacman -Qd"
alias pacqdt="sudo pacman -Qdt"
alias pacqdtq="sudo pacman -Qdtq"
alias pacqip="sudo pacman -Qip"
alias pacqii="sudo pacman -Qii"
alias pacqil="sudo pacman -Qil"
alias pacqkk="sudo pacman -Qkk"
alias pacqkq="sudo pacman -Qkq"
alias pacquq="sudo pacman -Qii"
alias pacqoq="sudo pacman -Qii"
alias pacdk="sudo pacman -Dk"
alias pacu="sudo pacman -U"
alias pacf="sudo pacman -F"

# Paru aliases
alias parus="paru -S"
alias paruss="paru -Ss"
alias parusss="paru -Sss"
alias parusw="paru -Sw"
alias parusy="paru -Sy"
alias parusyy="paru -Syy"
alias parusu="paru -Su"
alias parusyu="paru -Syu"
alias parusyyu="paru -Syyu"
alias parusd="paru -Sd"
alias parusdd="paru -Sdd"
alias parusg="paru -Sg"
alias parusc="paru -Sc"
alias paruscc="paru -Scc"
alias parusi="paru -Si"
alias parusii="paru -Sii"
alias parur="paru -R"
alias parurc="paru -Rc"
alias parurs="paru -Rs"
alias parurn="paru -Rn"
alias parurd="paru -Rd"
alias parurns="paru -Rns"
alias parurnn="paru -Rnn"
alias parurdd="paru -Rdd"
alias paruq="paru -Q"
alias paruqe="paru -Qe"
alias paruql="paru -Ql"
alias paruqi="paru -Qi"
alias paruqs="paru -Qs"
alias paruqo="paru -Qo"
alias paruqu="paru -Qu"
alias paruqg="paru -Qg"
alias paruqm="paru -Qm"
alias paruqk="paru -Qk"
alias paruqr="paru -Qr"
alias paruqd="paru -Qd"
alias paruqdt="paru -Qdt"
alias paruqdtq="paru -Qdtq"
alias paruqip="paru -Qip"
alias paruqii="paru -Qii"
alias paruqil="paru -Qil"
alias paruqkk="paru -Qkk"
alias paruqkq="paru -Qkq"
alias paruquq="paru -Qii"
alias paruqoq="paru -Qii"
alias parudk="paru -Dk"
alias paruu="paru -U"
alias paruf="paru -F"

# Open the TODO file
alias todo="nvim ~/Obsidian-Vault/TODO.md"

# For adb
alias adb="/home/asa/Android/Sdk/platform-tools/adb"

#################################################
#                      END                      #
#################################################
