#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "signal-desktop"; then
    echo "Removing signal-desktop..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "signal-desktop"
fi
