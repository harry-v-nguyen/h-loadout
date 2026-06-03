#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "alacritty"; then
    echo "Removing alacritty..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "alacritty"

    # Strip alacritty entries from the XDG terminal layout list if the file exists
    if [ -f "$HOME/.config/xdg-terminals.list" ]; then
        sed -i '/^Alacritty/d' "$HOME/.config/xdg-terminals.list"
    fi
fi

