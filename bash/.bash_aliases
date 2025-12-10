#!/bin/bash

#################################################
#                 BASH ALIASES                  #
#################################################

# Rectify the last command with sudo
alias wtf='sudo $(history -p !!)'

# Correct the last mistake command
alias fk="fuck"

# Updating and Cleaning the packages
alias upd="sudo pacman -Syyu && yay -Syyu"
alias cln="sudo pacman -Sc && sudo pacman -Scc && yay -Sc && yay -Scc && sudo journalctl --vacuum-size=100M"

# Jumping to up directory
alias rt="cd /"
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# Explore the files
alias ef="yazi"

# Jump to the backward directory
alias bd="cd -"

# Editor aliases
alias v="nvim"
alias sv="sudo nvim"
# alias code="code-insiders"

# Exit the terminal
alias x="exit"

# Clear the terminal
alias cls="clear"

# Copying and Moving with progress bar
alias cp="advcp -giR"
alias mv="advmv -gi"

# For rm command
alias rm="rmtrash -iv"
alias rmf="rmtrash -rvf"

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
alias upd-mir="sudo reflector --verbose --latest 25 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

# Aliases for managing orphan packages
alias ls-orph="sudo pacman -Qdt"
alias cls-orph="pacman -Qdqt | sudo pacman -Rns -"

# Bouncing the swap memory
# Used to refresh, clean and troubleshoot the swap memory
# alias bounce_swap='sudo swapoff -a && sleep 10 && sudo swapon -a'

# Cleaning the cache memory
alias cls-cache="echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null"

# Switching the Power Profile
alias chpp="~/.dotfiles/bash/scripts/toggle_power_profile.sh"

# Switching the Monitor Position
alias chmp="~/.dotfiles/bash/scripts/monitor_position.sh"

# Setting the Keyboard
alias setkb="~/.dotfiles/bash/scripts/set_keyboard.sh"

# Load the LazyGit
alias lg="lazygit"

# Load the LazyDocker
alias ld="lazydocker"

# For the fortune
alias fortune="/usr/bin/fortune | cowsay | lolcat"
alias fortune-linux="/usr/bin/fortune | cowsay -f tux | lolcat"

# Set a alias for Bastard Operator From Hell (bofh)
alias bofh="/usr/bin/fortune bofh-excuses | cowsay | lolcat"
alias bofh-linux="/usr/bin/fortune bofh-excuses | cowsay -f tux | lolcat"

# Alias for history
alias hst="history | nvim"

# Alias to open any file in Hexdump
# alias hexread="function _hexread(){ hexdump -C '$1' | nvim; }; _hexread"

# Copy and Paste aliases
# alias copy="xclip -selection clipboard"
# alias paste="xclip -o -selection clipboard"
alias copy="xsel --clipboard --input"
alias paste="xsel --clipboard --output"

# Current time
alias now="date '+%Y-%m-%d %A %I:%M:%S %p %Z'"

# Reload the bash configuration
alias rbrc="source ~/.dotfiles/bash/.bashrc"
alias rbpf="source ~/.dotfiles/bash/.bash_profile"
alias rblo="source ~/.dotfiles/bash/.bash_logout"
alias rbal="source ~/.dotfiles/bash/.bash_aliases"
alias rbfn="source ~/.dotfiles/bash/.bash_functions"
alias rbexp="source ~/.dotfiles/bash/.bash_exports"
alias rbbnd="source ~/.dotfiles/bash/.bash_bindings"
alias rbkey="source ~/.bash_keys"

# Edit the bash configuration
alias ebrc="nvim ~/.dotfiles/bash/.bashrc"
alias ebpf="nvim ~/.dotfiles/bash/.bash_profile"
alias eblo="nvim ~/.dotfiles/bash/.bash_logout"
alias ebal="nvim ~/.dotfiles/bash/.bash_aliases"
alias ebfn="nvim ~/.dotfiles/bash/.bash_functions"
alias ebexp="nvim ~/.dotfiles/bash/.bash_exports"
alias ebbnd="nvim ~/.dotfiles/bash/.bash_bindings"
alias ebkey="nvim ~/.bash_keys"

# Bash Notes
alias bn="nvim ~/.dotfiles/bash/bash_notes.md"

# Alert for long running commands
alias alert='
if [ $? -eq 0 ]; then
    notify-send --urgency=normal -i terminal "✔ Command Succeeded" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'' )";
else
    notify-send --urgency=critical -i error "✖ Command Failed" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'' )";
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

# Open the TODO file
alias todo="nvim ~/obsidian/TODO.md"

# For adb
alias adb="~/Android/Sdk/platform-tools/adb"

# Ping the Google
alias pgle="ping google.com -c 11"
alias ping="ping -c 11"
alias pgh="gping"

# Speedtest
alias speedtest="speedtest-cli"

# For the neofetch
alias fetch="neofetch --off"

# Review the code
alias code-count="scc -upw"

# For list the files
alias ls="eza --icons=always --color=always --group-directories-first --long --git --no-permissions --no-filesize --no-user --no-time"
alias lls="eza --icons=always --color=always --group-directories-first --all --long --git --no-permissions --no-filesize --no-user --no-time"
alias lt="eza --icons=always --color=always --group-directories-first --long --ignore-glob 'node_modules|.git' --git --no-permissions --no-filesize --no-user --no-time --tree"
alias llt="eza --icons=always --color=always --group-directories-first --all --long --ignore-glob 'node_modules|.git' --git --no-permissions --no-filesize --no-user --no-time --tree"
alias lf="eza --icons=always --color=always --group-directories-first --long --git --no-permissions --no-filesize --no-user --no-time --only-files"
alias llf="eza --icons=always --color=always --group-directories-first --all --long --git --no-permissions --no-filesize --no-user --no-time --only-files"
alias ldir="eza --icons=always --color=always --group-directories-first --long --git --no-permissions --no-filesize --no-user --no-time --only-dirs"
alias lldir="eza --icons=always --color=always --group-directories-first --all --long --git --no-permissions --no-filesize --no-user --no-time --only-dirs"
alias la="eza --icons=always --color=always --group-directories-first --long --git --git-repos"
alias lla="eza --icons=always --color=always --group-directories-first --all --long --git --git-repos"
alias lst="eza --icons=always --color=always --group-directories-first --long --git --no-permissions --no-filesize --no-user --no-time --sort"
alias llst="eza --icons=always --color=always --group-directories-first --all --long --git --no-permissions --no-filesize --no-user --no-time --sort"

# Process Management
alias p="procs --tree"

# To see if a command is aliased, a file, or a built-in command
alias check-cmd="type -a"

# Show open ports
alias open-ports='netstat -nape --inet'

# See the metadata of the file
alias meta="exiftool"

# For duplicates
alias dup="fdupes -r"

# For the disk usage
alias df="duf"
alias du="ncdu"

# For monitoring the bandwidth
alias band="sudo bandwhich"

# For train
alias train="sl"

# For `figlet`
alias ascii="figlet"

# For mount and unmount the drives
alias pdm="udisksctl mount -b"
alias pdum="udisksctl unmount -b"

# i3 configuration files
alias i3cf="nvim ~/.dotfiles/i3/config"

# list the all mounted drives
alias lmd="lsscsi"

# For editing the python development packages
alias eprq="nvim ~/.dotfiles/env/py/requirements-common.txt"
alias eprq-tf="nvim ~/.dotfiles/env/py/requirements-tf-cuda.txt"
alias eprq-torch="nvim ~/.dotfiles/env/py/requirements-torch-cuda.txt"
alias eprq-jax="nvim ~/.dotfiles/env/py/requirements-jax-cuda.txt"

# For install the python development packages
alias iprq="pip install -r ~/.dotfiles/env/py/requirements-common.txt"
alias iprq-tf="pip install -r ~/.dotfiles/env/py/requirements-tf-cuda.txt"
alias iprq-torch="pip install -r ~/.dotfiles/env/py/requirements-torch-cuda.txt"
alias iprq-jax="pip install -r ~/.dotfiles/env/py/requirements-jax-cuda.txt"

# Tree Grow Live
alias liv="cbonsai -liv"

#################################################
#                      END                      #
#################################################
