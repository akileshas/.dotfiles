#!/bin/bash

# starting the post-installation script
echo "Post-Installing the required packages for my system..."

# path to requirements file
file_path="/home/$USER/.dotfiles/env/sys/post-requirements.txt"

# function to print a formatted message
banner() {
    local message=" $1 "
    local end="${2,,}"
    local total_width=108
    local label_len=${#message}
    local pad_len=$(( (total_width - label_len) / 2 ))
    local pad=$(printf "=%.0s" $(seq 1 $pad_len))
    local extra=$(( (total_width - label_len) % 2 ))
    local extra_pad=$(printf "=%.0s" $(seq 1 $extra))

    if [[ "$end" == "done" ]]; then
        echo "${pad}${message}${extra_pad}${pad}"
    else
        echo && echo "${pad}${message}${extra_pad}${pad}"
    fi
}

# install the required packages
if [ -f "$file_path" ]; then
    banner "Installing the required packages !!!"
    sudo pacman -Syu
    paru -Syu

    while IFS= read -r package; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        banner "Installing: $package"
        paru -S --noconfirm "$package"
    done <"$file_path"

    banner "Installed the required packages !!!" done
    echo
else
    echo && echo "Error: File not found at $file_path"
    exit 1
fi

# activating the `ufw` service
echo && echo "Activating the 'ufw' service..."
sudo ufw enable
sudo systemctl enable --now ufw
sudo systemctl start --now ufw
sudo ufw status verbose
echo "Activating the 'ufw' service... Done."

# setting the `rust` environment
echo && echo "Setting the rust environment..."
rustup default stable
rustup update
echo "Setting the rust environment... Done."

# running the `broot` cmd
echo "Running the 'broot' cmd..."
broot
echo "Running the 'broot' cmd... Done."

echo "Post-Installing the required packages for my system... Done."
