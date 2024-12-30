#!/bin/bash

# Interactively kills selected Tmux sessions using `fzf`
tks() {
    # Check if tmux is installed
    if ! command -v tmux &>/dev/null; then
        echo "Error: tmux is not installed."
        return 1
    fi

    # Check if there are any existing tmux sessions
    local sessions_count
    sessions_count=$(tmux ls 2>/dev/null | wc -l)

    if [[ "$sessions_count" -eq 0 ]]; then
        echo "No tmux sessions are currently running."
        return 1
    fi

    # Get Tmux sessions and select with fzf
    local sessions
    sessions=$(tmux ls | fzf --exit-0 --multi) || {
        echo "No sessions selected."
        return 1
    }

    # Process each selected session
    while IFS= read -r session; do
        # Extract session name before the colon
        local session_name="${session%%:*}"
        if [[ -n $session_name ]]; then
            echo "Killing session: $session_name"
            tmux kill-session -t "$session_name" || echo "Failed to kill session: $session_name"
        fi
    done <<<"$sessions"
}

# Attach to a running Tmux session
tas() {
    # Check if tmux is installed
    if ! command -v tmux &>/dev/null; then
        echo "Error: tmux is not installed."
        return 1
    fi

    # Check if there are any existing tmux sessions
    local sessions_count
    sessions_count=$(tmux ls 2>/dev/null | wc -l)

    if [[ "$sessions_count" -eq 0 ]]; then
        echo "No tmux sessions are currently running."
        return 1
    fi

    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    # List sessions with tmux ls and allow selection via fzf
    session=$(tmux ls 2>/dev/null | fzf --exit-0) || {
        echo "No sessions selected or found."
        return 1
    }

    # Extract the session name (everything before the first ':')
    session=${session%%:*}
    # Attach or switch to the selected session
    tmux $change -t "$session" || {
        echo "Failed to attach to session: $session"
        return 1
    }
}

# Tmux session Handler
t() {
    # Inspired by ThePrimeagen & Sarguru AIDS
    # Check if tmux is installed
    if ! command -v tmux &>/dev/null; then
        echo "Error: tmux is not installed."
        return 1
    fi

    local selected selected_name tmux_running
    local required_dirs ignore_dirs dir_list

    # Define required directories
    required_dirs=(
        ~/Repository
        ~/Downloads/tmp
        ~/Personal
        ~/.dotfiles
    )

    # Define directories to ignore
    ignore_dirs=()

    # Commands for directory and file previews
    local DIR_PREVIEW_CMD="eza --icons=always --color=always --group-directories-first --all --long --ignore-glob 'node_modules|.git' --git --no-permissions --no-filesize --no-user --no-time --tree"
    local FILE_PREVIEW_CMD="bat --color=always --number"

    # Preview command to determine if the selected item is a directory or file
    local SHOW_FILE_OR_DIR_OR_CMD_PREVIEW="
    if [ -d '{}' ]; then
        $DIR_PREVIEW_CMD '{}';
    elif [ -f '{}' ]; then
        $FILE_PREVIEW_CMD '{}';
    else
        echo '{}';
    fi
    "

    # If a directory is provided as an argument, use it; otherwise, prompt the user
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        # Generate the list of directories including required_dirs
        dir_list=$(
            {
                for dir in "${required_dirs[@]}"; do
                    echo "$dir"
                    find "$dir" -mindepth 1 -maxdepth 3 -type d 2>/dev/null
                done
            } |
                # If ignore_dirs is not empty, filter out the ignored directories
                {
                    if [[ ${#ignore_dirs[@]} -gt 0 ]]; then
                        grep -v -E "$(printf "%s|" "${ignore_dirs[@]}" | sed 's/|$//')"
                    else
                        cat
                    fi
                } |
                fzf --exit-0 \
                    --border \
                    --preview="$SHOW_FILE_OR_DIR_OR_CMD_PREVIEW" \
        ) || {
            echo "Error: No directory selected."
            return 1
        }
        selected=$dir_list
    fi

    # Exit if no selection is made
    if [[ -z $selected ]]; then
        echo "Error: No directory selected."
        return 1
    fi

    # Generate session name by replacing dots with underscores
    parent_folder=$(basename "$(dirname "$selected")")
    selected_name="${parent_folder}___$(basename "$selected" | tr . _)"

    # Check if Tmux is running
    tmux_running=$(pgrep tmux)

    # If not inside Tmux and Tmux isn't running, start a new session
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        if ! tmux new-session -s "$selected_name" -c "$selected" 2>/dev/null; then
            echo "Error: Failed to create a new Tmux session."
            return 1
        fi
        return 0
    fi

    # Check if the session already exists
    if ! tmux has-session -t="$selected_name" 2>/dev/null; then
        # Create the new session
        if ! tmux new-session -ds "$selected_name" -c "$selected" 2>/dev/null; then
            echo "Error: Failed to create a new Tmux session."
            return 1
        fi
    fi

    # Attach to the session or switch if already inside Tmux
    if [[ -z $TMUX ]]; then
        if ! tmux attach-session -t "$selected_name" 2>/dev/null; then
            echo "Error: Failed to attach to Tmux session."
            return 1
        fi
    else
        if ! tmux switch-client -t "$selected_name" 2>/dev/null; then
            echo "Error: Failed to switch to Tmux session."
            return 1
        fi
    fi
}