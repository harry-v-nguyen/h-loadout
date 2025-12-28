#!/usr/bin/env bash

set -e

echo "Installing go..."

sudo dnf install -y golang

go install golang.org/x/tools/gopls@latest
