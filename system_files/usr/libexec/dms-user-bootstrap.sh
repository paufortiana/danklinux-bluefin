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
DEFAULT_DMS_CONFIG_DIR="/usr/share/dms/DankMaterialShell/config"
USER_DMS_CONFIG_DIR="$HOME/.config/DankMaterialShell"
DEFAULT_DMS_STATE_DIR="/usr/share/dms/DankMaterialShell/state"
USER_DMS_STATE_DIR="$STATE_DIR/DankMaterialShell"
DEFAULT_ALACRITTY_DIR="/usr/share/dms/alacritty"
USER_ALACRITTY_DIR="$HOME/.config/alacritty"

# Seed niri config
if [[ ! -e "$USER_NIRI_DIR/config.kdl" && -d "$DEFAULT_NIRI_DIR" ]]; then
    cp -a "$DEFAULT_NIRI_DIR" "$USER_NIRI_DIR"
fi

# Seed dank settings config
if [[ ! -e "$USER_DMS_CONFIG_DIR/settings.json" && -d "$DEFAULT_DMS_CONFIG_DIR" ]]; then
    cp -a "$DEFAULT_DMS_CONFIG_DIR" "$USER_DMS_CONFIG_DIR"
fi

# Seed alacritty config
if [[ ! -e "$USER_ALACRITTY_DIR/alacritty.toml" && -d "$DEFAULT_ALACRITTY_DIR" ]]; then
    cp -a "$DEFAULT_ALACRITTY_DIR" "$USER_ALACRITTY_DIR"
fi

# Seed wallpaper config
if [[ ! -e "$USER_DMS_STATE_DIR/session.json" ]]; then
    mkdir -p "$USER_DMS_STATE_DIR"
    cp -a "$DEFAULT_DMS_STATE_DIR/session.json" "$USER_DMS_STATE_DIR/session.json"
fi

touch "$STATE_FILE"
