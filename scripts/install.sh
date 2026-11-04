#!/usr/bin/env bash
# Desktop setup: symlink every config into place. Safe to re-run.
#
# Usage: scripts/install.sh [--packages]
#   --packages  also install packages.txt (pacman + AUR helper) and clone
#               Oh My Zsh, Powerlevel10k and the zsh plugins if missing
set -euo pipefail

# shellcheck source=lib.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
PLASMA_THEMES="$HOME/.local/share/plasma/look-and-feel"

# "path in repo:destination"
LINKS=(
  "alacritty:$CONFIG_DIR/alacritty"
  "tmux/.tmux.conf:$HOME/.tmux.conf"
  "zsh/.zshrc:$HOME/.zshrc"
  "zsh/.aliases:$HOME/.aliases"
  "zsh/.p10k.zsh:$HOME/.p10k.zsh"
  "nvim:$CONFIG_DIR/nvim"
  "git/.gitconfig:$HOME/.gitconfig"
  "git/ignore:$CONFIG_DIR/git/ignore"
  "ssh/config:$HOME/.ssh/config"
  "themes/bis.dark:$PLASMA_THEMES/bis.dark"
  "themes/bis.light:$PLASMA_THEMES/bis.light"
)

install_packages() {
  command -v pacman >/dev/null || die "--packages needs pacman (Arch Linux)"

  local repo=() aur=() line helper
  while read -r line; do
    line="${line%%#*}"
    line="${line//[[:space:]]/}"
    [ -n "$line" ] || continue
    if [[ "$line" == aur:* ]]; then aur+=("${line#aur:}"); else repo+=("$line"); fi
  done <"$DOTFILES_DIR/packages.txt"

  info "Installing packages: ${repo[*]}"
  sudo pacman -S --needed "${repo[@]}"

  if [ ${#aur[@]} -gt 0 ]; then
    for helper in paru yay; do
      if command -v "$helper" >/dev/null; then
        info "Installing AUR packages with $helper: ${aur[*]}"
        "$helper" -S --needed "${aur[@]}"
        return
      fi
    done
    info "No AUR helper (paru/yay) found; install these yourself: ${aur[*]}"
  fi
}

clone() {
  if [ -d "$2" ]; then
    echo "✔ $2 already present"
  else
    info "Cloning $1"
    git clone --depth=1 "$1" "$2"
  fi
}

install_shell_plugins() {
  local zsh_dir="$HOME/.oh-my-zsh"
  local custom="$zsh_dir/custom"
  clone https://github.com/ohmyzsh/ohmyzsh.git "$zsh_dir"
  clone https://github.com/romkatv/powerlevel10k.git "$custom/themes/powerlevel10k"
  clone https://github.com/zsh-users/zsh-autosuggestions.git "$custom/plugins/zsh-autosuggestions"
  clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom/plugins/zsh-syntax-highlighting"
}

case "${1:-}" in
  "") ;;
  --packages)
    install_packages
    install_shell_plugins
    ;;
  *) die "unknown option: $1 (usage: install.sh [--packages])" ;;
esac

# Older versions linked the whole look-and-feel directory to themes/. Replace
# that link with a real directory so other installed themes can live there too.
[ -L "$PLASMA_THEMES" ] && rm "$PLASMA_THEMES"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

info "Linking dotfiles from $DOTFILES_DIR"
for entry in "${LINKS[@]}"; do
  link "$DOTFILES_DIR/${entry%%:*}" "${entry#*:}"
done

echo "✔ Dotfiles installed successfully!"
