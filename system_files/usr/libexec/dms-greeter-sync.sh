#!/usr/bin/bash

set -euo pipefail

export DMS_PRIVESC="${DMS_PRIVESC:-sudo}" # Preselect sudo as privilege escalation backend.

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE_FILE="$STATE_DIR/dms-greeter-sync.done"

wait_for_close() {
    if [[ -t 0 ]]; then
        echo ""
        read -r -p "Press Enter to close this window..."
    fi
}

mkdir -p "$STATE_DIR"

if [[ -e "$STATE_FILE" ]]; then
    exit 0
fi

echo "This window will run the DMS greeter synchronization for your user account."
echo "After changing the wallpaper or theme, you may would like to run 'dms greeter sync' on your terminal to apply the changes on login screen."
echo ""
echo "Starting: dms greeter sync..."

if ! /usr/bin/dms greeter sync -y; then
    echo ""
    echo "dms greeter sync did not complete. It will retry on next login." >&2
    wait_for_close
    exit 1
fi

touch "$STATE_FILE"
echo ""
echo "dms greeter sync completed successfully."
wait_for_close
