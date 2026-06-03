#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "pinta"; then
    echo "Removing pinta..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "pinta"
fi
