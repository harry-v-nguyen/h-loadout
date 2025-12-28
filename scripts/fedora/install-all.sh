#!/usr/bin/env bash

set -e

echo -e "Installing specified packages...\n"

./scripts/fedora/install/install-bash-completion.sh
./scripts/fedora/install/install-eza.sh
./scripts/fedora/install/install-fzf.sh
./scripts/fedora/install/install-go.sh
./scripts/fedora/install/install-stow.sh
./scripts/fedora/install/install-tmux.sh

echo "Finished installing specified packages..."
