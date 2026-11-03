#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/Projects/dotfiles"
CONFIG_DIR="$HOME/.config"

source "$(dirname "$0")/lib.sh"

mkdir -p "$CONFIG_DIR"

# Alacritty
link "$DOTFILES_DIR/alacritty" "$CONFIG_DIR/alacritty"

# Tmux
link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Zsh
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.aliases" "$HOME/.aliases"

# Neovim
link "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# Git
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Themes
link "$DOTFILES_DIR/themes" "$HOME/.local/share/plasma/look-and-feel"

echo -e "✔ Dotfiles installed successfully!"
