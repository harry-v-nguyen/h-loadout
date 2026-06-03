#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "kdenlive"; then
    echo "Removing kdenlive..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "kdenlive"
fi
