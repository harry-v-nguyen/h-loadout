#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "aether"; then
    echo "Removing aether..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "aether"
fi
