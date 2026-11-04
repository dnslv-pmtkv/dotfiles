#!/usr/bin/env bash
# Shared helpers for dotfiles install scripts. Source, don't execute.

# Repo root, wherever it was cloned.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles_backup}"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
die() {
  printf '\033[1;31mError:\033[0m %s\n' "$*" >&2
  exit 1
}

# link <src> <dest>: symlink dest -> src. An existing dest that isn't already
# the right link is moved to $BACKUP_DIR with a timestamp. Safe to re-run.
link() {
  local src="$1" dest="$2" backup

  [ -e "$src" ] || die "link source does not exist: $src"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✔ $dest already linked"
    return
  fi

  # dest reached through a symlinked parent can be the source itself;
  # backing it up would move the repo's own files away.
  if [ -e "$dest" ] && [ "$(realpath "$dest")" = "$(realpath "$src")" ]; then
    die "$dest resolves to $src itself (symlinked parent directory?)"
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    backup="$BACKUP_DIR/$(basename "$dest").$(date +%Y%m%d-%H%M%S).bak"
    mkdir -p "$BACKUP_DIR"
    echo "Backing up $dest → $backup"
    mv "$dest" "$backup"
  fi

  echo "Linking $src → $dest"
  ln -s "$src" "$dest"
}
