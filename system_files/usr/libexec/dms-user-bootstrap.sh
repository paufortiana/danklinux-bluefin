#!/usr/bin/bash

set -euo pipefail

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE_FILE="$STATE_DIR/dms-user-bootstrap.done"

mkdir -p "$STATE_DIR"

if [[ -e "$STATE_FILE" ]]; then
    exit 0
fi

mkdir -p "$HOME/.config"
DEFAULT_NIRI_DIR="/usr/share/dms/niri"
USER_NIRI_DIR="$HOME/.config/niri"
DEFAULT_DANK_DIR="/usr/share/dms/DankMaterialShell"
USER_DANK_DIR="$HOME/.config/DankMaterialShell"
DEFAULT_ALACRITTY_DIR="/usr/share/dms/alacritty"
USER_ALACRITTY_DIR="$HOME/.config/alacritty"

# Seed niri config
if [[ ! -e "$USER_NIRI_DIR/config.kdl" && -d "$DEFAULT_NIRI_DIR" ]]; then
    cp -a "$DEFAULT_NIRI_DIR" "$USER_NIRI_DIR"
fi

# Seed dank settings config
if [[ ! -e "$USER_DANK_DIR/settings.json" && -d "$DEFAULT_DANK_DIR" ]]; then
    cp -a "$DEFAULT_DANK_DIR" "$USER_DANK_DIR"
fi

# Seed alacritty config
if [[ ! -e "$USER_ALACRITTY_DIR/alacritty.toml" && -d "$DEFAULT_ALACRITTY_DIR" ]]; then
    cp -a "$DEFAULT_ALACRITTY_DIR" "$USER_ALACRITTY_DIR"
fi

touch "$STATE_FILE"
