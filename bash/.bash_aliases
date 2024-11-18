#!/bin/bash

#################################################
#                 BASH ALIASES                  #
#################################################



# Rectify the last command with sudo
alias wtf='sudo $(history -p !!)'

# Correct the last mistake command
alias fk="fuck"

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
alias rm-orph="pacman -Qdqt | sudo pacman -Rns -"

# Bouncing the swap memory
# Used to refresh, clean and troubleshoot the swap memory
# alias bounce_swap='sudo swapoff -a && sleep 10 && sudo swapon -a'

# Cleaning the cache memory
alias cls-cache="echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null"

# MySQL Path
alias mysql="/usr/bin/mariadb -u asa -p"

# Switching the Power Profile
alias chpp="~/.dotfiles/i3/scripts/toggle_power_profile.sh"

# Switching the Monitor Position
alias chmp="~/.dotfiles/i3/scripts/monitor_position.sh"

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
alias hexread="function _hexread(){ hexdump -C '$1' | nvim; }; _hexread"

# Copy and Paste aliases
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"

# Current time
alias now="date '+%Y-%m-%d %A %I:%M:%S %p %Z'"

# cd into the old directory
alias bd="cd '$OLDPWD'"

# Reload the bash configuration
alias rbrc="source ~/.bashrc"
alias rbpf="source ~/.bash_profile"
alias rblo="source ~/.bash_logout"
alias rbal="source ~/.bash_aliases"
alias rbfn="source ~/.bash_functions"
alias rbexp="source ~/.bash_exports"
alias rbvar="source ~/.bash_variables"
alias rbkey="source ~/.bash_keys"

# Edit the bash configuration
alias ebrc="nvim ~/.bashrc"
alias ebpf="nvim ~/.bash_profile"
alias eblo="nvim ~/.bash_logout"
alias ebal="nvim ~/.bash_aliases"
alias ebfn="nvim ~/.bash_functions"
alias ebexp="nvim ~/.bash_exports"
alias ebvar="nvim ~/.bash_variables"
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



#################################################
#                      END                      #
#################################################
