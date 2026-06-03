#!/usr/bin/env bash

set -e

echo "Installing go..."

~/.local/share/omarchy/bin/omarchy-pkg-add "go"

go install golang.org/x/tools/gopls@latest
