#!/usr/bin/env bash
# PipeWire: virtual sinks (game/discord/music) looped back into the main output,
# so each app can be routed and recorded separately.
#
# Machine-specific: audio/90-mix-to-main.conf hardcodes this machine's output
# device (alsa_output.usb-streamplify_...). Find yours with:
#   pactl list short sinks
set -euo pipefail

# shellcheck source=lib.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

DEST="${XDG_CONFIG_HOME:-$HOME/.config}/pipewire/pipewire-pulse.conf.d"

link "$DOTFILES_DIR/audio/virtual-sinks.conf" "$DEST/virtual-sinks.conf"
link "$DOTFILES_DIR/audio/90-mix-to-main.conf" "$DEST/90-mix-to-main.conf"

info "Restarting PipeWire"
systemctl --user restart pipewire pipewire-pulse wireplumber

echo "✔ Audio setup done."
