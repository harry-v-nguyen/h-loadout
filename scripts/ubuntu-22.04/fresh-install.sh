#!/usr/bin/env bash

set -e

echo -e "Configuring fresh install...\n"

./scripts/ubuntu-22.04/install-all.sh
echo ""
./scripts/ubuntu-22.04/setup-all.sh

echo "Finished configuring fresh install..."
