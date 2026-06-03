#!/usr/bin/env bash

set -e

if ~/.local/share/omarchy/bin/omarchy-pkg-present "cliamp"; then
    echo "Removing cliamp..."
    ~/.local/share/omarchy/bin/omarchy-pkg-drop "cliamp"
fi
