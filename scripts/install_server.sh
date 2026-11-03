#!/usr/bin/env bash
# Minimal server setup: git + SSH auth/signing key, nothing else.
# Usage on a fresh server:
#   curl -fsSL https://raw.githubusercontent.com/dnslv-pmtkv/dotfiles/main/scripts/install_server.sh | bash
# Safe to re-run.
set -euo pipefail

REPO_HTTPS="https://github.com/dnslv-pmtkv/dotfiles.git"
REPO_SSH="git@github.com:dnslv-pmtkv/dotfiles.git"
DOTFILES_DIR="$HOME/Projects/dotfiles"
SSH_DIR="$HOME/.ssh"
KEY="$SSH_DIR/id_ed25519"
ALLOWED_SIGNERS="$HOME/.config/git/allowed_signers"

info() { echo -e "\033[1;34m==>\033[0m $*"; }
die()  { echo -e "\033[1;31mError:\033[0m $*" >&2; exit 1; }

# Ask a y/N question on the terminal even when the script is piped into bash.
ask_yes() {
  local reply=""
  if { exec 3</dev/tty; } 2>/dev/null; then
    read -r -u 3 -p "$1 [y/N] " reply || true
    exec 3<&-
  fi
  [[ "$reply" =~ ^[Yy]$ ]]
}

# 1. Packages ---------------------------------------------------------------
SUDO=""
if [ "$(id -u)" -ne 0 ]; then
  command -v sudo >/dev/null || die "not root and sudo is not installed"
  SUDO="sudo"
fi

if command -v git >/dev/null && command -v ssh-keygen >/dev/null && command -v ssh-keyscan >/dev/null; then
  info "git and openssh already installed"
elif command -v apt-get >/dev/null; then
  info "Installing git + openssh via apt"
  $SUDO apt-get update -qq
  $SUDO apt-get install -y git openssh-client
elif command -v dnf >/dev/null; then
  info "Installing git + openssh via dnf"
  $SUDO dnf install -y git openssh-clients
elif command -v pacman >/dev/null; then
  info "Installing git + openssh via pacman"
  $SUDO pacman -Sy --needed --noconfirm git openssh
elif command -v apk >/dev/null; then
  info "Installing git + openssh via apk"
  $SUDO apk add --no-cache git openssh-client openssh-keygen
else
  die "no supported package manager found (apt, dnf, pacman, apk)"
fi

# 2. Clone dotfiles ---------------------------------------------------------
if [ -d "$DOTFILES_DIR/.git" ]; then
  info "Updating $DOTFILES_DIR"
  git -C "$DOTFILES_DIR" pull --ff-only || info "pull failed, continuing with existing checkout"
else
  info "Cloning dotfiles into $DOTFILES_DIR"
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  git clone "$REPO_HTTPS" "$DOTFILES_DIR"
fi

# 3. Link gitconfig ---------------------------------------------------------
# shellcheck source=lib.sh
source "$DOTFILES_DIR/scripts/lib.sh"
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

EMAIL="$(git config --global user.email)"

# 4. SSH key ----------------------------------------------------------------
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$KEY" ]; then
  info "SSH key $KEY already exists"
else
  info "Generating SSH key $KEY"
  comment="$EMAIL@$(uname -n)"
  if ask_yes "Protect the new key with a passphrase?"; then
    ssh-keygen -t ed25519 -C "$comment" -f "$KEY"   # prompts on the tty
  else
    ssh-keygen -t ed25519 -C "$comment" -f "$KEY" -N ""
  fi
fi
chmod 600 "$KEY"
chmod 644 "$KEY.pub"

# 5. GitHub host key --------------------------------------------------------
touch "$SSH_DIR/known_hosts"
chmod 600 "$SSH_DIR/known_hosts"
if ssh-keygen -F github.com -f "$SSH_DIR/known_hosts" >/dev/null; then
  info "github.com already in known_hosts"
else
  info "Adding github.com to known_hosts"
  ssh-keyscan -t ed25519 github.com 2>/dev/null >> "$SSH_DIR/known_hosts"
fi

# 6. allowed_signers (for verifying SSH-signed commits) ---------------------
mkdir -p "$(dirname "$ALLOWED_SIGNERS")"
touch "$ALLOWED_SIGNERS"
signer_line="$EMAIL namespaces=\"git\" $(cut -d' ' -f1,2 "$KEY.pub")"
if grep -qxF "$signer_line" "$ALLOWED_SIGNERS"; then
  info "allowed_signers already contains this key"
else
  info "Adding key to $ALLOWED_SIGNERS"
  echo "$signer_line" >> "$ALLOWED_SIGNERS"
fi

# 7. Next steps -------------------------------------------------------------
cat <<EOF

✔ Server git setup done.

Public key:

  $(cat "$KEY.pub")

Next steps:
  1. Add it on GitHub TWICE at https://github.com/settings/ssh/new
       - once as "Authentication Key"
       - once as "Signing Key"
  2. Test auth:
       ssh -T git@github.com
  3. Switch the dotfiles clone to SSH:
       git -C $DOTFILES_DIR remote set-url origin $REPO_SSH
EOF
