#!/bin/bash

#################################################
#                 Bash Aliases                  #
#################################################



# ----------- Commanly Used Commands -----------


# Fetch
alias fetch="neofetch --off"
alias ifetch="neofetch"

# Ping
alias pg="ping google.com -c 5"
alias ping="ping -c 5"
alias fastping="ping -c 100 -s.2"




# ----------- Git Commands -----------

alias gitst="git status"
alias gita="git add"
alias gitaa="git add ."
alias gitau="git add -u"
alias gitc="git commit"
alias gitcm="git commit -m"
alias gitca="git commit -am"
alias gitcl="git clone"
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
alias la="eza -all"
alias ll="ls --all"
alias lt="ls --tree"
alias ltl="ls --tree --all"

# ----------- END -----------

