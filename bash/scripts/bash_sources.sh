#!/bin/bash

# Sourcing all the required bash files
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source global definitions from /etc/bash.bashrc
if [ -f /etc/bash.bashrc ]; then
    source /etc/bash.bashrc
fi

# Require `bash-completion` package to be installed
# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Source the bash completion scripts
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Source all bash completion scripts in /etc/bash_completion.d/
if [ -d /etc/bash_completion.d ]; then
    for file in /etc/bash_completion.d/*; do
        [ -f "$file" ] && . "$file"
    done
fi

# List of files to check and source from ~/.dotfiles/bash
# Check if the file exists and source it
bash_files=(
    "bash_aliases"
    "bash_exports"
    "bash_functions"
    "bash_bindings"
)

for file in "${bash_files[@]}"; do
    if [ -f "$HOME/.dotfiles/bash/.$file" ]; then
        . "$HOME/.dotfiles/bash/.$file"
    fi
done

# Source ~/.bash_keys if it exists
if [ -f "$HOME/.bash_keys" ]; then
    . "$HOME/.bash_keys"
fi

# Source the python virtual environment activation script
if [ -f "$HOME/.dotfiles/bash/scripts/conda_functions.sh" ]; then
    . "$HOME/.dotfiles/bash/scripts/conda_functions.sh"
fi

# Source the `tmux` functions
if [ -f "$HOME/.dotfiles/bash/scripts/tmux_functions.sh" ]; then
    . "$HOME/.dotfiles/bash/scripts/tmux_functions.sh"
fi
