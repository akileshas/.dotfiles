# Dotfiles

Welcome to my dotfiles repository! Here you'll find configurations for:

- Bash
- Git
- i3
- Sway
- Kitty
- Qt
- GTK
- Neofetch
- Neovim (nvim)
- Vim
- Starship (prompt)
- Tmux
- Tmate
- Hyprland
- Rofi
- Waybar
- lazygit
- Zed

Feel free to explore and customize these configurations to suit your preferences!

My nvim config profile : [nvim-profile](https://dotfyle.com/akileshas/dotfiles-nvim)

---

## Setting up the tmux configurations:

```bash
# Install the git
sudo pacman -Syu git git-delta github-cli
# Configure your git to your github account

# Initially instally some of the neccessary nerd fonts
sudo pacman -S otf-firamono-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-sourcecodepro-nerd ttf-ubuntu-mono-nerd ttf-hack-nerd ttf-noto-nerd ttf-hack-nerd

# Clone the tmux plugin manager (tpm) in the desired directory
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Cloning the repository in the home directory
git clone https://github.com/akileshas/.dotfiles.git

# Going to /home directory
cd

# Copying the tmux configuration file to the desired location
cp ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Opening the tmux
tmux new -s Session
# To install all the plugins press ` + I(shift+i/Capital letter 'i')
```

## Setting up the neovim configurations:

```bash
# Initially instally some of the neccessary nerd fonts
sudo pacman -S otf-firamono-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-sourcecodepro-nerd ttf-ubuntu-mono-nerd ttf-hack-nerd ttf-noto-nerd ttf-hack-nerd

# Adding some dependencies
# For Archlinux
sudo pacman -Syu git neovim nodejs npm wget curl unzip ripgrep lazygit
# Instead of using the nodejs and npm directly from the pacman
# we can use the Node Version Manager (NVM)
paru -Syu nvm
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
source ~/.bashrc
nvm install --lts
nvm use --lts

# Going to /home directory
cd

# Cloning the repository in the home directory
git clone https://github.com/akileshas/.dotfiles.git

# Moving/Copying the neovim configuration files to the desired directory:
rm -rf ~/.config/nvim
cp -r ~/.dotfiles/nvim ~/.config/nvim

# Just open the neovim
# All the packages get's installed automatically
nvim
```
