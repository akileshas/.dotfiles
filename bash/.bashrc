#!/bin/bash

#################################################
#                     BASH                      #
#################################################



# ----------- Common Initialization -----------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Check if the ~/.bash_aliases file exists and if so, source it
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Check if the ~/.bash_functions file exists and if so, source it
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# ----------- END -----------



# ----------- Zoxide (better cd) -----------

eval "$(zoxide init bash)"

# ----------- END -----------



# ----------- Starship Initialization -----------

eval "$(starship init bash)"

# ----------- END -----------



# ----- Bat (better cat) -----

export BAT_THEME=ansi

# ----------- END -----------



# ----------- TheFuck Initialization -----------

eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ----------- END -----------



# ----------- Conda Initialization -----------

# !! Contents within this block are managed by 'conalias now='date "+%Y-%m-%d %H:%M:%S"'da init' !!
__conda_setup="$('/home/asa/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/asa/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/asa/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/asa/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# ----------- END -----------



# ----------- FZF -----------

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
export FZF_COMPLETION_TRIGGER='~~'

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Setup the fzf-git
source ~/fzf-git.sh/fzf-git.sh

# Setup the fzf theme
fg="#CBE0F0"
bg="-1"
bg_highlight="-1"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Setup fzf previews with eza and bat

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :100000 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# ----------- END -----------



#################################################
#                      END                      #
#################################################
