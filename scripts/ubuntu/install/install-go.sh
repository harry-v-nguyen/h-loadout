#!/usr/bin/env bash

set -e

echo "Installing go..."

sudo apt update && sudo apt install -y golang

go install golang.org/x/tools/gopls@v0.20.0
