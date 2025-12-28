#!/usr/bin/env bash

set -e

echo -e "Configuring fresh install...\n"

./scripts/fedora/install-all.sh
echo ""
./scripts/fedora/setup-all.sh

echo "Finished configuring fresh install..."
