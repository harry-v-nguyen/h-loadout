#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "obs-studio"; then
    echo "Removing obs-studio..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "obs-studio"
fi
