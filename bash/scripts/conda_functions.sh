#!/bin/bash

pl() {
    # Check if Conda is installed
    if ! command -v conda &>/dev/null; then
        echo "Conda is not installed. Please install Conda first."
        return 1
    fi

    # Get the list of Conda environments and display it
    conda env list |
        sed '/^#/d; /^[[:space:]]*$/d; s/\*/ /' |
        while read -r env_name env_path; do
            if [[ -f "$env_path/bin/python" ]]; then
                py_version=$("$env_path/bin/python" --version 2>&1)
                echo "$env_name $py_version $env_path"
            else
                echo "$env_name Error: Python not found in $env_path"
            fi
        done |
        column -t
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
            sed '/^#/d; /^[[:space:]]*$/d; s/\*/ /' |
            while read -r env_name env_path; do
                if [[ -f "$env_path/bin/python" ]]; then
                    py_version=$("$env_path/bin/python" --version 2>&1)
                    echo "$env_name $py_version $env_path"
                else
                    echo "$env_name Error: Python not found in $env_path"
                fi
            done |
            column -t |
            fzf --border=rounded \
                --height=21 \
                --tmux center,80%,60%
    )

    # If the choice is not empty, activate the environment
    if [[ -n "$choice" ]]; then
        env_name=$(echo "$choice" | awk '{print $1}')
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
    read -p "Enter the Python version ( 3.11 ): " python_version

    # Set default Python version if none is provided
    if [[ -z "$python_version" ]]; then
        python_version="3.11"
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

        # Ask the user if they want to install packages from the requirements file
        read -p "Do you want to install packages from the requirements file? (y/N): " install_packages
        if [[ "$install_packages" == "y" ]]; then
            # Path to the requirements file
            requirements_file="$HOME/.dotfiles/env/py/requirements-common.txt"

            # Check if the requirements file exists
            if [[ -f "$requirements_file" ]]; then
                echo "Installing packages from $requirements_file..."
                pip install -r "$requirements_file" && echo "Packages installed successfully."
            else
                echo "Requirements file not found: $requirements_file"
            fi
        else
            echo "Skipping package installation."
        fi
    else
        echo "Failed to activate environment: $env_name"
        return 1
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
            sed '/^#/d; /^[[:space:]]*$/d; s/\*/ /' |
            while read -r env_name env_path; do
                if [[ -f "$env_path/bin/python" ]]; then
                    py_version=$("$env_path/bin/python" --version 2>&1)
                    echo "$env_name $py_version $env_path"
                else
                    echo "$env_name Error: Python not found in $env_path"
                fi
            done |
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
