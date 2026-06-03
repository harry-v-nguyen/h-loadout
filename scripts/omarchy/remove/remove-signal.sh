#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "signal"; then
    echo "Removing signal..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "signal"
fi
