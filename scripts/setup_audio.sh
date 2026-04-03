#!/usr/bin/env bash
set -e

SRC="$HOME/Projects/dotfiles/audio"
DEST="$HOME/.config/pipewire/pipewire-pulse.conf.d"
BACKUP_DIR="$HOME/.dotfiles_backup"

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

mkdir -p "$DEST"

link "$SRC/virtual-sinks.conf" "$DEST/virtual-sinks.conf"

systemctl --user restart pipewire pipewire-pulse wireplumber

echo "Symlinks installed."



