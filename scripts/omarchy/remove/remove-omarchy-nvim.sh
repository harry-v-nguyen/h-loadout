#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "omarchy-nvim"; then
    echo "Removing omarchy-nvim..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "omarchy-nvim"

    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
fi
