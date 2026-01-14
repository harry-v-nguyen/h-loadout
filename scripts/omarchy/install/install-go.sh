#!/usr/bin/env bash

set -e

echo "Installing go..."

yay -Syu --noconfirm --needed go

go install golang.org/x/tools/gopls@latest
