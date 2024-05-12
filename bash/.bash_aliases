#!/bin/bash

#################################################
#                 Bash Aliases                  #
#################################################



# ----------- Commanly Used Commands -----------

# Clean & Exit
alias x='exit'
alias cls='clear'

# Fetch
alias fetch="fastfetch"
alias ifetch="uwufetch -i"

# Date and Time
alias now='date "+%Y-%m-%d %H:%M:%S"'

# Editting and Refreshing the Bash files
alias edit-bash="nvim ~/.bashrc"
alias edit-bash-aliases="nvim ~/.bash_aliases"
alias edit-bash-functions="nvim ~/.bash_functions"
alias reload-bash="source ~/.bashrc"

# Mirrors
alias update-mirror="sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias list-mirror="bat /etc/pacman.d/mirrorlist"

# Managing Packages
alias update="sudo pacman -Syu && yay -Syu && flatpak update"
alias force-update="sudo pacman -Syyu && yay -Syyu && flatpak update"
alias clean="sudo pacman -Scc && yay -Scc"

# Ping
alias pg="ping google.com -c 5"
alias ping="ping -c 5"
alias fastping="ping -c 100 -s.2"

# Reboot
alias restart="sudo reboot"
alias reboot="sudo reboot"
alias sysreboot="sudo systemctl reboot"

# Shutdown
alias bye="sudo shutdown -h now"
alias shutdown="sudo shutdown -h now"

# ----------- END -----------



# ----------- Pacman Commands -----------

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
alias pacqip="sudo pacman -Qip"
alias pacqii="sudo pacman -Qii"
alias pacqil="sudo pacman -Qil"
alias pacqkk="sudo pacman -Qkk"
alias pacqkq="sudo pacman -Qkq"
alias pacquq="sudo pacman -Qii"
alias pacqoq="sudo pacman -Qii"
alias pacu="sudo pacman -U"
alias pacf="sudo pacman -F"

# ----------- END -----------



# ----------- Yay Commands -----------

alias yays="yay -S"
alias yayss="yay -Ss"
alias yaysss="yay -Sss"
alias yaysw="yay -Sw"
alias yaysy="yay -Sy"
alias yaysyy="yay -Syy"
alias yaysu="yay -Su"
alias yaysyu="yay -Syu"
alias yaysyyu="yay -Syyu"
alias yaysd="yay -Sd"
alias yaysdd="yay -Sdd"
alias yaysg="yay -Sg"
alias yaysc="yay -Sc"
alias yayscc="yay -Scc"
alias yaysi="yay -Si"
alias yaysii="yay -Sii"
alias yayr="yay -R"
alias yayrc="yay -Rc"
alias yayrs="yay -Rs"
alias yayrn="yay -Rn"
alias yayrd="yay -Rd"
alias yayrns="yay -Rns"
alias yayrnn="yay -Rnn"
alias yayrdd="yay -Rdd"
alias yayq="yay -Q"
alias yayqe="yay -Qe"
alias yayql="yay -Ql"
alias yayqi="yay -Qi"
alias yayqs="yay -Qs"
alias yayqo="yay -Qo"
alias yayqu="yay -Qu"
alias yayqg="yay -Qg"
alias yayqm="yay -Qm"
alias yayqk="yay -Qk"
alias yayqr="yay -Qr"
alias yayqd="yay -Qd"
alias yayqdt="yay -Qdt"
alias yayqip="yay -Qip"
alias yayqii="yay -Qii"
alias yayqil="yay -Qil"
alias yayqkk="yay -Qkk"
alias yayqkq="yay -Qkq"
alias yayquq="yay -Qii"
alias yayqoq="yay -Qii"
alias yayu="yay -U"
alias yayf="yay -F"

# ----------- END -----------



# ----------- More Jump down -----------

alias rt='cd /'
alias ~="cd ~"
alias ..='cd ..'
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ----------- END -----------



# ----------- Git Commands -----------

alias gitst="git status"
alias gita="git add"
alias gitaa="git add ."
alias gitau="git add -u"
alias gitc="git commit"
alias gitcm="git commit -m"
alias gitca="git commit -am"
alias gitb="git branch"
alias gitbd="git branch -d"
alias gitco="git checkout"
alias gitcob="git checkout -b"
alias gitt="git stash"
alias gitta="git stash apply"
alias gitm="git merge"
alias gitr="git rebase"
alias gitl="git log --oneline --decorate --graph"
alias gitlog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gitlga="git log --graph --oneline --all --decorate"
alias gitsh="git show"
alias gitd="git diff"
alias gitdclr="git diff --color --color-words --abbrev"
alias gitdc="git diff --cached"
alias gitbl="git blame"
alias gitps="git push"
alias gitpl="git pull"
alias gitk="gitk --all&"
alias gitx="gitx --all"

# show ignored files by git
alias gitsignf="ls-files -o -i --exclude-standard"

# Untrack Files without deleting them
alias gitrmc="git rm -r --cached"

# ----------- END -----------



# ----------- Eza (better ls) -----------

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ll="ls --all"
alias lt="ls --tree"
alias ltl="ls --tree --all"

# ----------- END -----------



# ----------- Grep Commands -----------

alias grep='grep --color=auto'        # Basic grep alias with color
alias grepi='grep -i --color=auto'    # Case-insensitive search with color
alias grepn='grep -n --color=auto'    # Show line numbers with color
alias grepc='grep -c --color=auto'    # Show count of matches with color
alias grepr='grep -r --color=auto'    # Recursive search in directories with color
alias greprh='grep -Rh --color=auto'  # Recursive search with hidden files with color
alias grepe='grep -E --color=auto'    # Use extended regular expressions with color
alias grepv='grep -v --color=auto'    # Inverse match with color
alias grepf='grep -F --color=auto'    # Fixed string search with color
alias grepg='grep -G --color=auto'    # Basic regex search with color
alias greps='grep -s --color=auto'    # Suppress error messages with color
alias greprv='grep -rv --color=auto'  # Recursive search with inverse match and color
alias grepl='grep -l --color=auto'    # Print only filenames with matches and color
alias grepx='grep -x --color=auto'    # Match entire lines only with color
alias grepw='grep -w --color=auto'    # Match whole words only with color

# ----------- END -----------



#################################################
#                      END                      #
#################################################
