#!/bin/bash

#################################################
#                BASH FUNCTIONS                 #
#################################################



# Clean the Compiled Python Files
cls-pyc() {
    # Remove all .pyc files recursively
    find . -name '*.pyc' -delete
}

# Creates a directory (if it doesn't exist) and changes into it
mcd() {
    # If a directory name is provided, create the directory and move into it
    [[ "$1" ]] && mkdir -p "$1" && cd "$1"
}

# Reset the git repository
nah() {
    git reset --hard

    if [[ $1 == "-f" ]]; then
        git clean -df
    fi
}

# Open the default program for the file
open() {
    xdg-open $* >/dev/null 2>&1
}

# Network Information
netinfo() {
    echo "--------------- Network Information ---------------"

    # Display network interfaces (excluding loopback)
    for iface in $(ip -o link show | awk -F': ' '{print $2}' | grep -v 'lo'); do
        echo "Interface: $iface"

        # Get the IPv4 address
        ipv4=$(ip -o -4 addr show dev $iface | awk '{print $4}')
        echo "IP Address (IPv4): $ipv4"

        # Get the IPv6 address
        ipv6=$(ip -o -6 addr show dev $iface | awk '{print $4}')
        echo "IP Address (IPv6): $ipv6"

        # Get the netmask (CIDR)
        netmask=$(ip -o -4 addr show dev $iface | awk '{print $4}' | cut -d/ -f2)
        echo "Netmask (IPv4): $netmask"

        # Get the broadcast address
        broadcast=$(ip -o addr show dev $iface | awk '/broadcast/ {print $4}')
        echo "Broadcast Address: $broadcast"

        # Get the MAC address
        mac=$(ip link show dev $iface | awk '/ether/ {print $2}')
        echo "MAC Address: $mac"

        # Get the default gateway
        gateway=$(ip route show dev $iface default | awk '/default/ {print $3}')
        echo "Default Gateway: $gateway"

        echo "---------------------------------------------------"
    done
}

# Returns the last 2 fields of the working directory
pwdtail() {
    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# cd to the back directory
# bd() {
#     local backdir=$OLDPWD
#     cd $backdir
# }

# reading the hexa value of a file
hexaread() {
    hexdump -C "$1" | nvim
}

# Function to get the local IP address
get-local-ip() {
    local ips=$(ip addr show | awk '/inet / {print $2}' | cut -d/ -f1)
    echo "Local IP addresses:"
    for ip in $ips; do
        echo "    -> $ip"
    done
}

# Function to get the public IP address
get-public-ip() {
    local ip=$(curl -s ifconfig.me)
    echo "Public IP address:"
    echo "    -> $ip"
}

# Function to get the ip information
get-ip() {
    echo "IP Information:"

    local ips=$(ip addr show | awk '/inet / {print $2}' | cut -d/ -f1)
    echo "    => Local IP addresses:"
    for ip in $ips; do
        echo "        -> $ip"
    done

    local ip=$(curl -s ifconfig.me)
    echo "    => Public IP address:"
    echo "        -> $ip"

}

# `fzf` configuration function
# Use `fd` to generate the list for path completion
_fzf_compgen_path() {
    fd --hidden --no-ignore --no-ignore-parent --ignore-case --follow --exclude .git --exclude node_modules --strip-cwd-prefix
}

# Use `fd` to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type directory --hidden --no-ignore --no-ignore-parent --ignore-case --follow --exclude .git --exclude node_modules --strip-cwd-prefix
}

# Advanced `fzf` completion function
_fzf_comprun() {
    # Commands for directory and file previews
    local DIR_PREVIEW_CMD="eza --icons=always --color=always --group-directories-first --all --long --ignore-glob .git --ignore-glob node_modules --git --no-permissions --no-filesize --no-user --no-time --tree"
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

    # Preview command for SSH connections
    local SSH_PREVIEW_CMD="
    echo '### DNS Information ###';
    dig '{}' 2>/dev/null || echo 'No DNS records found !!!';

    echo; echo '### Ping Test ###'; echo;
    ping -c 3 '{}' 2>/dev/null || echo 'Host unreachable !!!';

    echo; echo '### SSH Key Fingerprint ###'; echo;
    ssh-keyscan '{}' 2>/dev/null || echo 'Unable to fetch SSH key fingerprint !!!';
    "

    # Preview for export/unset
    local EXPORT_UNSET_PREVIEW_CMD="
    if env | grep -q '^{}='; then
        echo '### Variable Name ###';
        echo '{}';

        echo; echo '### Current Value ###';
        env | grep '^{}=' | cut -d'=' -f2-;
    else
        echo 'Variable not set: {}';
    fi
    "

    # Preview for unalias
    local UNALIAS_PREVIEW_CMD="
    echo 'alias {}';
    "

    # Process the first argument to determine the command
    local command=$1
    shift

    case "$command" in
    ssh)
        fzf --preview "$SSH_PREVIEW_CMD" "$@"
        ;;
    export | unset)
        fzf --preview "$EXPORT_UNSET_PREVIEW_CMD" "$@"
        ;;
    unalias)
        fzf --preview "$UNALIAS_PREVIEW_CMD" "$@"
        ;;
    *)
        fzf --preview "$SHOW_FILE_OR_DIR_OR_CMD_PREVIEW" "$@"
        ;;
    esac
}

# Function to activate the python virtual environment
pa() {
    # Check if Conda is installed
    if ! command -v conda &>/dev/null; then
        echo "Conda is not installed. Please install Conda first."
        return 1
    fi

    # Get the list of Conda environments and process it
    choice=$(
        conda env list |
            sed 's/\*/ /;1,2d' |
            xargs -I {} bash -c '
            env_name_path=({});
            env_path=${env_name_path[1]};
            if [[ -f "$env_path/bin/python" ]]; then
                py_version=$($env_path/bin/python --version 2>&1);
                echo "${env_name_path[0]} ${py_version#* } ${env_path}";
            else
                echo "Error: Python not found in $env_path";
            fi
        ' |
            column -t |
            fzf --border=rounded \
                --height=21 \
                --tmux center,50%,50%
    )

    # If the choice is not empty, activate the environment
    if [[ -n "$choice" ]]; then
        env_name=$(echo $choice | awk '{print $1}')
        # Try activating the environment and handle potential errors
        if conda activate "$env_name"; then
            echo "Activated environment: $env_name"
        else
            echo "Failed to activate environment: $env_name"
        fi
    else
        echo "No environment selected."
    fi
}

# Function to deactivate the python virtual environment
pd() {
    conda deactivate
}

# Function to create a new python virtual environment
pc() {
    # Check if Conda is installed
    if ! command -v conda &>/dev/null; then
        echo "Conda is not installed. Please install Conda first."
        return 1
    fi

    # Ask the user if they want to create a new environment
    read -p "Do you want to create a new Conda environment? (y/N): " create_env
    if [[ "$create_env" != "y" ]]; then
        echo "Environment creation cancelled."
        return 1
    fi

    # Get the name of the new environment
    read -p "Enter the name of the new environment: " env_name
    read -p "Enter the Python version ( 3.10 ): " python_version

    # Set default Python version if none is provided
    if [[ -z "$python_version" ]]; then
        python_version="3.10"
        echo "No Python version provided. Using default version: $python_version"
    fi

    # Create the new environment with the specified name and Python version
    if conda create -n "$env_name" python="$python_version" -y; then
        echo "Created environment: $env_name with Python $python_version"
    else
        echo "Failed to create environment: $env_name"
        return 1
    fi

    # Activate the new environment
    if conda activate "$env_name"; then
        echo "Activated environment: $env_name"
    else
        echo "Failed to activate environment: $env_name"
    fi
}

# Function to delete the python virtual environment
pr() {
    # Check if Conda is installed
    if ! command -v conda &>/dev/null; then
        echo "Conda is not installed. Please install Conda first."
        return 1
    fi

    # Get the list of Conda environments and process it
    choice=$(
        conda env list |
            sed 's/\*/ /;1,2d' |
            xargs -I {} bash -c '
            env_name_path=({});
            env_path=${env_name_path[1]};
            if [[ -f "$env_path/bin/python" ]]; then
                py_version=$($env_path/bin/python --version 2>&1);
                echo "${env_name_path[0]} ${py_version#* } ${env_path}";
            else
                echo "Error: Python not found in $env_path";
            fi
        ' |
            column -t |
            fzf --border=rounded \
                --height=21 \
                --tmux center,50%,50%
    )

    # If the choice is not empty, delete the environment
    if [[ -n "$choice" ]]; then
        env_name=$(echo $choice | awk '{print $1}')
        read -p "Are you sure you want to delete the environment '$env_name'? (y/N): " confirm
        if [[ "$confirm" == "y" ]]; then
            # Suppress verbose output during environment deletion
            echo "Deleting environment '$env_name'..."
            conda env remove --name "$env_name" --yes &>/dev/null

            # Check if the environment was successfully deleted
            if [[ $? -eq 0 ]]; then
                echo "Environment '$env_name' deleted successfully."
            else
                echo "Failed to delete environment '$env_name'."
            fi
        else
            echo "Environment deletion cancelled."
        fi
    else
        echo "No environment selected."
    fi
}

# Function to list all the script commands
fnode() {
    # Ensure required tools are installed
    if ! command -v jq &>/dev/null || ! command -v fzf &>/dev/null; then
        echo "Error: Both 'jq' and 'fzf' must be installed."
        return 1
    fi

    # Check if package.json exists in the current directory
    if [ ! -f package.json ]; then
        echo "Error: No package.json found in the current directory."
        return 1
    fi

    # Extract script names from package.json and display with fzf
    local script
    script=$(jq -r '.scripts | keys[]' package.json 2>/dev/null | sort | fzf)

    # If a script was selected
    if [ -n "$script" ]; then
        echo "You selected script: $script"

        # Prompt user to choose a package manager
        echo "Select a package manager:"
        local pm
        pm=$(printf "npm\nyarn\nbun" | fzf)

        # Validate the package manager choice
        case "$pm" in
        npm)
            echo "Running with npm: $script"
            npm run "$script"
            ;;
        yarn)
            echo "Running with yarn: $script"
            yarn "$script"
            ;;
        bun)
            echo "Running with bun: $script"
            bun run "$script"
            ;;
        *)
            echo "Error: Invalid package manager selected."
            return 1
            ;;
        esac
    else
        echo "No script selected."
    fi
}



#################################################
#                      END                      #
#################################################
