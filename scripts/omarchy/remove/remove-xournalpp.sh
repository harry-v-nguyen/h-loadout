#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "xournalpp"; then
    echo "Removing xournalpp..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "xournalpp"
fi
