#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "obsidian"; then
    echo "Removing obsidian..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "obsidian"
fi
