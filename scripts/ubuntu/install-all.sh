#!/usr/bin/env bash

set -e

echo -e "Installing specified packages...\n"

./scripts/ubuntu/install/install-bash-completion.sh
./scripts/ubuntu/install/install-eza.sh
./scripts/ubuntu/install/install-fzf.sh
./scripts/ubuntu/install/install-go.sh
./scripts/ubuntu/install/install-stow.sh
./scripts/ubuntu/install/install-tmux.sh

echo "Finished installing specified packages..."