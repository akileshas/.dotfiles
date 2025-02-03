#!/bin/bash

# Checking if `paru` is installed
if ! command -v paru &>/dev/null; then
    echo "Error: 'paru' is not installed"
    echo "Please install 'paru' and run the script again"
    exit 1
fi

# Updating and Syncing the system
echo "Updating and Syncing the system..."
sudo pacman -Syu
paru -Syu

# Path to requirements file
file_path="/home/$USER/.dotfiles/env/sys/post-requirements.txt"

# Install the required packages for the system
if [ -f "$file_path" ]; then
    echo "Installing the required packages..."
    sudo pacman -Syu
    paru -Syu
    while IFS= read -r package; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        echo "Installing: $package"
        paru -S --noconfirm "$package"
    done <"$file_path"
    echo "Installed the required packages"
else
    echo "Error: File not found at $file_path"
    exit 1
fi

# Activating the `ufw` service
echo "Activating the 'ufw' service..."
sudo ufw enable
sudo systemctl enable --now ufw
sudo systemctl start --now ufw
sudo ufw status verbose
echo "Activated the 'ufw' service"

# Setting the `nvm` environment
echo "Setting the nvm environment..."
nvm install --lts
nvm use --lts
echo "Set the nvm environment"

# Setting the `rust` environment
echo "Setting the rust environment..."
rustup default stable
rustup update
echo "Set the rust environment"

# Running the `broot` cmd
echo "Running the 'broot' cmd..."
broot
echo "Ran the 'broot' cmd"

echo "Completed the Post Setup !!!"
