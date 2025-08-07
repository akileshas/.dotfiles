#!/bin/bash

#################################################
#                     BASH                      #
#################################################

# Starting the timer
# This will be used to measure the time taken to source the file
# The timer will be stopped at the end of the file
total_start_time=$(date +%s.%N)

### --- Checking bash --- ###

# Not bash ?
[ -n "${BASH_VERSION:-}" ] || return 0

# Not an interactive shell ?
[[ $- == *i* ]] || return 0

# Function to measure and display sourcing time
validate_source() {
    local start end duration source_file="$1"
    if [ -f "$source_file" ]; then
        start=$(date +%s.%N)
        . "$source_file"
        end=$(date +%s.%N)
        duration=$(echo "$end - $start" | bc)
        printf "[\033[1;32m✓\033[0m](\033[1;34m%.5f\033[0m) %s\n" "$duration" "$source_file"
    else
        printf "[\033[1;31m✗\033[0m](\033[1;33mSkipped\033[0m) %s\n" "$source_file"
        sleep 5
    fi
}

### --- Initialization and Sourcing the required file  --- ###

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
interactiveShellTest=$(expr index "$-" i)

# Disable the bell
if [[ $interactiveShellTest > 0 ]]; then bind "set bell-style visible"; fi

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $interactiveShellTest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
# if [[ $interactiveShellTest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Source the custom script for additional configurations
validate_source "$HOME/.dotfiles/bash/scripts/bash_sources.sh"

# MiniConda initialization
if [ "$(hostnamectl hostname)" = "asa" ]; then
    validate_source "$HOME/.dotfiles/bash/scripts/miniconda.sh"
elif [ "$(hostnamectl hostname)" = "GGS" ]; then
    validate_source "$HOME/.dotfiles/bash/scripts/ggs/miniconda.sh"
fi

# NVM initialization
# Check if the nvm initialization script exists before sourcing
validate_source /usr/share/nvm/init-nvm.sh

### --- Shell Prompt Customization --- ###

# Setting the Starship prompt
if command -v /bin/starship &>/dev/null; then
    eval "$(starship init bash)"
fi

# Setting the PS1 prompt
PS1='[\u@\h \W]\$ '

### --- Useful Cmdline tools --- ###

# Activating the `zoxide` tool for directory navigation ( better than `cd` )
# Check if the zoxide tool is available
if command -v /bin/zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# Initialing TheFuck
if command -v /bin/thefuck &>/dev/null; then
    eval $(thefuck --alias)
fi

# Activating the `fzf` tool for fuzzy search
# Check if the fzf tool is available
if command -v /bin/fzf &>/dev/null; then
    eval "$(fzf --bash)"
fi

### --- Activating some features of the `bash` shell --- ###

# Enable the `extglob` shell option
# This will enable the extended pattern matching features
shopt -s extglob

# Enable the `dotglob` shell option
# This will include the hidden files when globbing
shopt -s dotglob

# Enable the `nullglob` shell option
# This will make the glob expand to an empty string when it matches nothing
# instead of the literal characters
# shopt -s nullglob

# Enable the `cdspell` shell option
# This will fix spelling errors for `cd`, only in interactive shell
shopt -s cdspell

# Enable the `noclobber` shell option
# This will append outputs to the file, don't overwrite it
set -o noclobber

# Enable the `vi` mode
set -o vi

### --- Customizing the `bash` shell bindings --- ###

# Finally soucing the `bash_bindings` file
validate_source "$HOME/.dotfiles/bash/.bash_bindings"

### --- Greeting's --- ###

# Executing the Greeting script
# Check if the file exists and execute it
source "$HOME/.dotfiles/bash/scripts/greeting.sh"

# Stopping the timer
total_end_time=$(date +%s.%N)
total_duration=$(echo "$total_end_time - $total_start_time" | bc)
printf "[\033[1;32m✓\033[0m](\033[1;34m%.5f\033[0m) %s\n" "$total_duration" "$HOME/.bashrc"

#################################################
#                      END                      #
#################################################
