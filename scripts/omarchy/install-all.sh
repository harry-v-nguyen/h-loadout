#!/usr/bin/env bash

set -e

echo -e "Installing specified packages...\n"

./scripts/omarchy/install/install-bash-completion.sh
./scripts/omarchy/install/install-go.sh
./scripts/omarchy/install/install-lsof.sh
./scripts/omarchy/install/install-opencode.sh
./scripts/omarchy/install/install-starship.sh
./scripts/omarchy/install/install-stow.sh
./scripts/omarchy/install/install-telegram.sh
./scripts/omarchy/install/install-tmux.sh
./scripts/omarchy/install/install-veracrypt.sh
./scripts/omarchy/install/install-zen.sh

echo "Finished installing specified packages..."
