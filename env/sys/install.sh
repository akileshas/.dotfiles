#!/bin/bash
# Author: Akilesh A S
# Created on: 17-01-2025
# Last modified on: 17-01-2025
# Description: A script to install the required packages for my system

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
file_path="/home/$USER/.dotfiles/env/sys/requirements.txt"

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

# Setup the fonts requirements
echo "Installing the required fonts..."
sudo pacman -Syu
paru -Syu
sudo pacman -S otf-aurulent-nerd otf-codenewroman-nerd otf-comicshanns-nerd otf-commit-mono-nerd otf-droid-nerd otf-firamono-nerd otf-geist-mono-nerd otf-hasklig-nerd otf-hermit-nerd otf-monaspace-nerd otf-opendyslexic-nerd otf-overpass-nerd ttf-0xproto-nerd ttf-3270-nerd ttf-agave-nerd ttf-anonymouspro-nerd ttf-arimo-nerd ttf-bigblueterminal-nerd ttf-bitstream-vera-mono-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-cousine-nerd ttf-d2coding-nerd ttf-daddytime-mono-nerd ttf-dejavu-nerd ttf-envycoder-nerd ttf-fantasque-nerd ttf-firacode-nerd ttf-go-nerd ttf-gohu-nerd ttf-hack-nerd ttf-heavydata-nerd ttf-iawriter-nerd ttf-ibmplex-mono-nerd ttf-inconsolata-go-nerd ttf-inconsolata-lgc-nerd ttf-inconsolata-nerd ttf-intone-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-iosevkatermslab-nerd ttf-jetbrains-mono-nerd ttf-lekton-nerd ttf-liberation-mono-nerd ttf-lilex-nerd ttf-martian-mono-nerd ttf-meslo-nerd ttf-monofur-nerd ttf-monoid-nerd ttf-mononoki-nerd ttf-mplus-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttf-profont-nerd ttf-proggyclean-nerd ttf-recursive-nerd ttf-roboto-mono-nerd ttf-sharetech-mono-nerd ttf-sourcecodepro-nerd ttf-space-mono-nerd ttf-terminus-nerd ttf-tinos-nerd ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-victor-mono-nerd ttf-zed-mono-nerd noto-fonts-emoji
echo "Installed the fonts requirements"
echo "Updating the font cache..."
sudo fc-cache -fv
echo "Setting up the fonts... Done"

# Enable the bluetooth service
echo "Enabling the bluetooth service..."
sudo modprobe btusb
sudo systemctl enable bluetooth && sudo systemctl start bluetooth
echo "Enabled the bluetooth service"

# Install the Intel microcode
echo "Installing the Intel microcode..."
sudo pacman -Syu
paru -Syu
if [ "$(hostnamectl hostname)" = "ASA" ]; then
    sudo pacman -S intel-ucode
    echo "Installed the Intel microcode"
else
    echo "Not installing the Intel microcode"
fi

# Update the grub configuration
echo "Updating the grub configuration..."
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo "Updated the grub configuration"

# Activating the paccache timer
echo "Activating the paccache timer..."
sudo systemctl enable paccache.timer
sudo systemctl start paccache.timer
echo "Activated the paccache timer"
