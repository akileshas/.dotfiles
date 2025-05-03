#!/bin/bash


# Author: Akilesh A S
# Created on: 17-01-2025
# Last modified on: 03-05-2025
# Description: A script to install the required packages for my system


# starting the installation script
echo "Installling the required packages for my system..."

# checking if `paru` is installed
if ! command -v paru &>/dev/null; then
    echo
    echo "Error: 'paru' is not installed"
    echo "Please install 'paru' and run the script again"
    exit 1
fi

# updating and syncing the system
echo && echo "Updating and Syncing the system..."
sudo pacman -Syu
paru -Syu
echo "Updating and Syncing the system... Done"

# path to requirements file
file_path="/home/$USER/.dotfiles/env/sys/requirements.txt"

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

# setup the fonts requirements
banner "Installing the required fonts !!!"
sudo pacman -Syu
paru -Syu
sudo pacman -S otf-aurulent-nerd otf-codenewroman-nerd otf-comicshanns-nerd otf-commit-mono-nerd otf-droid-nerd otf-firamono-nerd otf-geist-mono-nerd otf-hasklig-nerd otf-hermit-nerd otf-monaspace-nerd otf-opendyslexic-nerd otf-overpass-nerd ttf-0xproto-nerd ttf-3270-nerd ttf-agave-nerd ttf-anonymouspro-nerd ttf-arimo-nerd ttf-bigblueterminal-nerd ttf-bitstream-vera-mono-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-cousine-nerd ttf-d2coding-nerd ttf-daddytime-mono-nerd ttf-dejavu-nerd ttf-envycoder-nerd ttf-fantasque-nerd ttf-firacode-nerd ttf-go-nerd ttf-gohu-nerd ttf-hack-nerd ttf-heavydata-nerd ttf-iawriter-nerd ttf-ibmplex-mono-nerd ttf-inconsolata-go-nerd ttf-inconsolata-lgc-nerd ttf-inconsolata-nerd ttf-intone-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-iosevkatermslab-nerd ttf-jetbrains-mono-nerd ttf-lekton-nerd ttf-liberation-mono-nerd ttf-lilex-nerd ttf-martian-mono-nerd ttf-meslo-nerd ttf-monofur-nerd ttf-monoid-nerd ttf-mononoki-nerd ttf-mplus-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttf-profont-nerd ttf-proggyclean-nerd ttf-recursive-nerd ttf-roboto-mono-nerd ttf-sharetech-mono-nerd ttf-sourcecodepro-nerd ttf-space-mono-nerd ttf-terminus-nerd ttf-tinos-nerd ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-victor-mono-nerd ttf-zed-mono-nerd noto-fonts-emoji noto-fonts noto-fonts-cjk wqy-zenhei adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
banner "Installed the fonts requirements !!!" done
echo && echo "Updating the font cache..."
sudo fc-cache -fv
echo && echo "Updating the font cache... Done"

# install the Intel microcode
banner "Installing the Intel microcode !!!"
sudo pacman -Syu
paru -Syu
if [ "$(hostnamectl hostname)" = "ASA" ]; then
    sudo pacman -S intel-ucode
    banner "Installed the Intel microcode !!!" done
else
    banner "Not installing the Intel microcode !!!" done
fi

# enable the bluetooth service
echo && echo "Enabling the bluetooth service..."
sudo modprobe btusb
sudo systemctl enable bluetooth && sudo systemctl start bluetooth
echo && echo "Enabling the bluetooth service... Done"

# update the grub
echo "Updating the grub..."
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo "Updating the grub... Done"

# activating the paccache timer
echo "Activating the paccache timer..."
sudo systemctl enable paccache.timer
sudo systemctl start paccache.timer
echo "Activating the paccache timer... Done"

# creating the required symbolic links
banner "Creating the required symbolic links !!!"

# for `i3`
echo "Creating the symbolic link for i3..."
if [[ -d ~/.config/i3 ]]; then
    rm -rf ~/.config/i3
    echo "Removed the existing i3 config !"
fi
ln -s ~/.dotfiles/i3 ~/.config/i3
echo "Creating the symbolic link for i3... Done"

# for `kitty`
echo "Creating the symbolic link for kitty..."
if [[ -d ~/.config/kitty ]]; then
    rm -rf ~/.config/kitty
    echo "Removed the existing kitty config !"
fi
ln -s ~/.dotfiles/kitty ~/.config/kitty
echo "Creating the symbolic link for kitty... Done"

# for `starship`
echo "Creating the symbolic link for starship..."
if [[ -d ~/.config/starship ]]; then
    rm -rf ~/.config/starship
    echo "Removed the existing starship config !"
fi
ln -s ~/.dotfiles/starship ~/.config/starship
echo "Created the symbolic link for starship... Done"

# for `lazygit`
echo "Creating the symbolic link for lazygit..."
if [[ -d ~/.config/lazygit ]]; then
    rm -rf ~/.config/lazygit
    echo "Removed the existing lazygit coinfig !"
fi
ln -s ~/.dotfiles/lazygit ~/.config/lazygit
echo "Created the symbolic link for lazygit... Done"

# for `gtk`
echo "Creating the symbolic link for gtk..."
if [[ -d ~/.config/gtk-2.0 ]]; then
    rm -rf ~/.config/gtk-2.0
    echo "Removed the existing gtk-2.0 config !"
fi
if [[ -d ~/.config/gtk-3.0 ]]; then
    rm -rf ~/.config/gtk-3.0
    echo "Removed the existing gtk-3.0 config !"
fi
if [[ -d ~/.config/gtk-4.0 ]]; then
    rm -rf ~/.config/gtk-4.0
    echo "Removed the existing gtk-4.0 config !"
fi
ln -s ~/.dotfiles/gtk/gtk-2.0 ~/.config/gtk-2.0
ln -s ~/.dotfiles/gtk/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/.dotfiles/gtk/gtk-4.0 ~/.config/gtk-4.0
echo "Created the symbolic link for gtk... Done"

# for `rofi`
echo "Creating the symbolic link for rofi..."
if [[ -d ~/.config/rofi ]]; then
    rm -rf ~/.config/rofi
    echo "Removed the existing rofi config !"
fi
ln -s ~/.dotfiles/rofi ~/.config/rofi
echo "Created the symbolic link for rofi... Done"

# for `formatter`
echo "Creating the symbolic link for formatter..."
if [[ -f ~/.prettierrc ]]; then
    rm -rf ~/.prettierrc
    echo "Removed the existing prettier config !"
fi
if [[ -f ~/.clang-format ]]; then
    rm -rf ~/.clang-format
    echo "Removed the existing clang-format config !"
fi
ln -s ~/.dotfiles/formatter/.prettierrc ~/.prettierrc
ln -s ~/.dotfiles/formatter/.clang-format ~/.clang-format
echo "Created the symbolic link for formatter... Done"

# for `tmux`
echo "Creating the symbolic link for tmux..."
if [[ -f ~/.tmux.conf ]]; then
    rm -rf ~/.tmux.conf
    echo "Removed the existing tmux config !"
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo "Created the symbolic link for tmux... Done"

# for `git`
echo "Creating the symbolic link for git..."
if [[ -f ~/.gitconfig ]]; then
    rm -rf ~/.gitconfig
    echo "Removed the existing git config !"
fi
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
echo "Created the symbolic link for git... Done"

# for `bash`
echo "Creating the symbolic link for bash..."
if [[ -f ~/.bashrc ]]; then
    rm -rf ~/.bashrc
    echo "Removed the existing bashrc file !"
fi
if [[ -f ~/.bash_profile ]]; then
    rm -rf ~/.bash_profile
    echo "Removed the existing bash_profile file !"
fi
if [[ -f ~/.bash_logout ]]; then
    rm -rf ~/.bash_logout
    echo "Removed the existing bash_logout file !"
fi
ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/.bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bash/.bash_logout ~/.bash_logout
touch ~/.bash_keys
echo "Created the symbolic link for bash... Done"

banner "Created the required symbolic links !!!" done

echo "Installling the required packages for my system... Done"
