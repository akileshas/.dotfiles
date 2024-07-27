# Dotfiles

Welcome to my dotfiles repository! Here you'll find configurations for:

- Bash
- Git
- Kitty
- Neofetch
- Neovim (nvim)
- Starship (prompt)
- Tmux
- Hyprland

Feel free to explore and customize these configurations to suit your preferences!

---

## Setting up the neovim configurations:

```bash
# Adding some dependencies
# For Archlinux
sudo pacman -Syu neovim nodejs npm cargo unzip ripgrep lazygit

# Going to /home directory
cd

# Cloning the repository in the home directory
git clone https://github.com/Akilesh-ML-Engineer/.dotfiles.git

# Adding the link of the neovim configuration files:
rm -rf ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim
```
