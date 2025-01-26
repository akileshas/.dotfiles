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
sudo pacman -S otf-aurulent-nerd otf-codenewroman-nerd otf-comicshanns-nerd otf-commit-mono-nerd otf-droid-nerd otf-firamono-nerd otf-geist-mono-nerd otf-hasklig-nerd otf-hermit-nerd otf-monaspace-nerd otf-opendyslexic-nerd otf-overpass-nerd ttf-0xproto-nerd ttf-3270-nerd ttf-agave-nerd ttf-anonymouspro-nerd ttf-arimo-nerd ttf-bigblueterminal-nerd ttf-bitstream-vera-mono-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-cousine-nerd ttf-d2coding-nerd ttf-daddytime-mono-nerd ttf-dejavu-nerd ttf-envycoder-nerd ttf-fantasque-nerd ttf-firacode-nerd ttf-go-nerd ttf-gohu-nerd ttf-hack-nerd ttf-heavydata-nerd ttf-iawriter-nerd ttf-ibmplex-mono-nerd ttf-inconsolata-go-nerd ttf-inconsolata-lgc-nerd ttf-inconsolata-nerd ttf-intone-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-iosevkatermslab-nerd ttf-jetbrains-mono-nerd ttf-lekton-nerd ttf-liberation-mono-nerd ttf-lilex-nerd ttf-martian-mono-nerd ttf-meslo-nerd ttf-monofur-nerd ttf-monoid-nerd ttf-mononoki-nerd ttf-mplus-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttf-profont-nerd ttf-proggyclean-nerd ttf-recursive-nerd ttf-roboto-mono-nerd ttf-sharetech-mono-nerd ttf-sourcecodepro-nerd ttf-space-mono-nerd ttf-terminus-nerd ttf-tinos-nerd ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-victor-mono-nerd ttf-zed-mono-nerd noto-fonts-emoji noto-fonts noto-fonts-cjk wqy-zenhei adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
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

# Creating the required symbolic links
# For `i3`
if [[ -d ~/.config/i3 ]]; then
    rm -rf ~/.config/i3
    echo "Removed the existing i3 directory"
fi
ln -s ~/.dotfiles/i3 ~/.config/i3
echo "Created the symbolic link for i3"

# For `kitty`
if [[ -d ~/.config/kitty ]]; then
    rm -rf ~/.config/kitty
    echo "Removed the existing kitty directory"
fi
ln -s ~/.dotfiles/kitty ~/.config/kitty
echo "Created the symbolic link for kitty"

# For `starship`
if [[ -d ~/.config/starship ]]; then
    rm -rf ~/.config/starship
    echo "Removed the existing starship directory"
fi
ln -s ~/.dotfiles/starship ~/.config/starship
echo "Created the symbolic link for starship"

# For `lazygit`
if [[ -d ~/.config/lazygit ]]; then
    rm -rf ~/.config/lazygit
    echo "Removed the existing lazygit directory"
fi
ln -s ~/.dotfiles/lazygit ~/.config/lazygit
echo "Created the symbolic link for lazygit"

# For `neofetch`
if [[ -d ~/.config/neofetch ]]; then
    rm -rf ~/.config/neofetch
    echo "Removed the existing neofetch directory"
fi
ln -s ~/.dotfiles/neofetch ~/.config/neofetch
echo "Created the symbolic link for neofetch"

# For `gtk`
if [[ -d ~/.config/gtk-2.0 ]]; then
    rm -rf ~/.config/gtk-2.0
    echo "Removed the existing gtk-2.0 directory"
fi
if [[ -d ~/.config/gtk-3.0 ]]; then
    rm -rf ~/.config/gtk-3.0
    echo "Removed the existing gtk-3.0 directory"
fi
if [[ -d ~/.config/gtk-4.0 ]]; then
    rm -rf ~/.config/gtk-4.0
    echo "Removed the existing gtk-4.0 directory"
fi
ln -s ~/.dotfiles/gtk/gtk-2.0 ~/.config/gtk-2.0
ln -s ~/.dotfiles/gtk/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/.dotfiles/gtk/gtk-4.0 ~/.config/gtk-4.0
echo "Created the symbolic link for gtk"

# For `rofi`
if [[ -d ~/.config/rofi ]]; then
    rm -rf ~/.config/rofi
    echo "Removed the existing rofi directory"
fi
ln -s ~/.dotfiles/rofi ~/.config/rofi
echo "Created the symbolic link for rofi"

# For `formatter`
if [[ -f ~/.prettierrc ]]; then
    rm -rf ~/.prettierrc
    echo "Removed the existing prettierrc file"
fi
if [[ -f ~/.clang-format ]]; then
    rm -rf ~/.clang-format
    echo "Removed the existing clang-format file"
fi
ln -s ~/.dotfiles/formatter/.prettierrc ~/.prettierrc
ln -s ~/.dotfiles/formatter/.clang-format ~/.clang-format
echo "Created the symbolic link for formatter"

# For `tmux`
if [[ -f ~/.tmux.conf ]]; then
    rm -rf ~/.tmux.conf
    echo "Removed the existing tmux.conf file"
fi
if [[ -f ~/.tmate.conf ]]; then
    rm -rf ~/.tmate.conf
    echo "Removed the existing tmate.conf file"
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/tmux/.tmate.conf ~/.tmate.conf
echo "Created the symbolic link for tmux"

# For `git`
if [[ -f ~/.gitconfig ]]; then
    rm -rf ~/.gitconfig
    echo "Removed the existing gitconfig file"
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
echo "Created the symbolic link for git"

# For `bash`
if [[ -f ~/.bashrc ]]; then
    rm -rf ~/.bashrc
    echo "Removed the existing bashrc file"
fi
if [[ -f ~/.bash_profile ]]; then
    rm -rf ~/.bash_profile
    echo "Removed the existing bash_profile file"
fi
if [[ -f ~/.bash_logout ]]; then
    rm -rf ~/.bash_logout
    echo "Removed the existing bash_logout file"
fi
ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/.bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bash/.bash_logout ~/.bash_logout
touch ~/.bash_keys
echo "Created the symbolic link for bash"

# For `nvim`
read -p "Do you add the nvim config? [y/N] " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    if [[ -d ~/.config/nvim ]]; then
        rm -rf ~/.config/nvim
        echo "Removed the existing nvim directory"
    fi
    ln -s ~/.dotfiles/nvim ~/.config/nvim
    echo "Created the symbolic link for nvim"
fi

echo "Completed the setup !!!"
