# dotfiles

## Desktop

Symlinks everything (alacritty, tmux, zsh, nvim, git, Plasma themes):

```sh
git clone git@github.com:dnslv-pmtkv/dotfiles.git ~/Projects/dotfiles
~/Projects/dotfiles/scripts/install.sh
```

## Server

Installs only git + openssh, links `.gitconfig`, generates an SSH key for
GitHub auth and commit signing, and sets up `allowed_signers`:

```sh
curl -fsSL https://raw.githubusercontent.com/dnslv-pmtkv/dotfiles/main/scripts/install_server.sh | bash
```

Then add the printed public key on GitHub as both an Authentication and a
Signing key. Safe to re-run.
