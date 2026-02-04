#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/Projects/dotfiles"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles_backup"

mkdir -p "$CONFIG_DIR"
mkdir -p "$BACKUP_DIR"

link() {
  local src="$1"
  local dest="$2"

  # If destination is a symlink pointing to the right place, do nothing
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✔ $dest already linked"
    return
  fi

  # If destination exists (file/dir or wrong symlink), back it up
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Backing up $dest → $BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/$(basename "$dest").bak"
  fi

  echo -e "Linking $src → $dest\n"
  ln -s "$src" "$dest"
}

# Alacritty
link "$DOTFILES_DIR/alacritty" "$CONFIG_DIR/alacritty"

# Tmux
link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Zsh
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Neovim
link "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# Git
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Themes
link "$DOTFILES_DIR/themes" "$HOME/.local/share/plasma/look-and-feel"

echo -e "✔ Dotfiles installed successfully!"
