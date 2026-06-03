#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "typora"; then
    echo "Removing typora..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "typora"
fi
