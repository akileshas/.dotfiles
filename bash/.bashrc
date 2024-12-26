#!/bin/bash

#################################################
#                     BASH                      #
#################################################



### --- Checking bash --- ###

# Not bash ?
[ -n "${BASH_VERSION:-}" ] || return 0

# Not an interactive shell ?
[[ $- == *i* ]] || return 0



### --- Greeting's --- ###

# Executing the Greeting script
# Check if the file exists and execute it
if [ -f "$HOME/.dotfiles/bash/scripts/greeting.sh" ]; then
    bash "$HOME/.dotfiles/bash/scripts/greeting.sh"
fi



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
if [ -f "$HOME/.dotfiles/bash/scripts/bash_sources.sh" ]; then
    . "$HOME/.dotfiles/bash/scripts/bash_sources.sh"
fi

# MiniConda initialization
if [ -f "$HOME/.dotfiles/bash/scripts/miniconda.sh" ]; then
    . "$HOME/.dotfiles/bash/scripts/miniconda.sh"
fi

# NVM initialization
# Check if the nvm initialization script exists before sourcing
if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi



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

# Setting the vim mode for the shell
set -o vi



#################################################
#                      END                      #
#################################################
