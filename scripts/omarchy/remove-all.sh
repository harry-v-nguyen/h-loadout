#!/usr/bin/env bash

set -e

echo -e "Removing specified packages...\n"

./scripts/omarchy/remove/remove-1password.sh
./scripts/omarchy/remove/remove-aether.sh
./scripts/omarchy/remove/remove-alacritty.sh
./scripts/omarchy/remove/remove-kdenlive.sh
./scripts/omarchy/remove/remove-obs.sh
./scripts/omarchy/remove/remove-obsidian.sh
./scripts/omarchy/remove/remove-omarchy-chromium.sh
./scripts/omarchy/remove/remove-pinta.sh
./scripts/omarchy/remove/remove-signal.sh
./scripts/omarchy/remove/remove-typora.sh
./scripts/omarchy/remove/remove-web-apps.sh
./scripts/omarchy/remove/remove-xournalpp.sh

echo "Finished removing specified packages..."
