#!/usr/bin/bash

set -euo pipefail

export DMS_PRIVESC="${DMS_PRIVESC:-sudo}" # Preselect sudo as privilege escalation backend.

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"
STATE_FILE="$STATE_DIR/dms-greeter-sync.done"
DMS_CACHE_DIR="${DMS_CACHE_DIR:-/var/cache/dms-greeter}"

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

if [[ -d "$DMS_CACHE_DIR" ]]; then
    if getfacl ~ ~/.config ~/.local ~/.cache ~/.local/state 2>/dev/null | grep -E '^user:greeter:' >/dev/null 2>&1; then
        echo "User already has greeter permissions. Skipping greeter sync."
        touch "$STATE_FILE"
        exit 0
    fi
fi


echo "This window will run the Dank Greeter synchronization for your user account (/usr/bin/dms greeter sync)."
echo ""
echo "Starting Dank Greeter synchronization..."

if ! /usr/bin/dms greeter sync -y; then
    echo ""
    echo "Dank Greeter synchronization did not complete. It will retry on next login." >&2
    wait_for_close
    exit 1
fi

touch "$STATE_FILE"
echo ""
echo "Dank Greeter synchronization completed successfully."
wait_for_close
