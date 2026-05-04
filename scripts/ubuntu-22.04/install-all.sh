#!/usr/bin/env bash

set -e

echo -e "Installing specified packages...\n"

./scripts/ubuntu-22.04/install/install-bash-completion.sh
./scripts/ubuntu-22.04/install/install-fzf.sh
./scripts/ubuntu-22.04/install/install-go.sh
./scripts/ubuntu-22.04/install/install-starship.sh
./scripts/ubuntu-22.04/install/install-stow.sh
./scripts/ubuntu-22.04/install/install-tmux.sh

echo "Finished installing specified packages..."
