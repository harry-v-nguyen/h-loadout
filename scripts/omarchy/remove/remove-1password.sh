#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "1password-beta"; then
    echo "Removing 1password-beta..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "1password-beta"
fi

if ~/.local/share/omarchy/bin/omarchy-pkg-present "1password-cli"; then
    echo "Removing 1password-cli..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "1password-cli"
fi
