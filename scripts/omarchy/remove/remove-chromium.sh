#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "chromium"; then
    echo "Removing chromium..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "chromium"
fi
