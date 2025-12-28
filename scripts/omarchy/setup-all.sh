#!/usr/bin/env bash

set -e

echo -e "Setting up configurations...\n"

./scripts/omarchy/setup/setup-font.sh
./scripts/omarchy/setup/setup-theme.sh
./scripts/omarchy/setup/setup-dotfiles.sh

echo "Finished setting up configurations..."
