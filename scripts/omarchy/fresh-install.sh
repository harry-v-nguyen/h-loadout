#!/usr/bin/env bash

set -e

echo -e "Configuring fresh install...\n"

./scripts/omarchy/remove-all.sh
echo ""
./scripts/omarchy/install-all.sh
echo ""
./scripts/omarchy/setup-all.sh

echo "Finished configuring fresh install..."
