#!/usr/bin/env bash
# Shared helpers for dotfiles install scripts. Source, don't execute.

BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles_backup}"
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
