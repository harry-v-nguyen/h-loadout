#!/usr/bin/env bash

set -e

echo -e "Configuring fresh install...\n"

./scripts/ubuntu/install-all.sh
echo ""
./scripts/ubuntu/setup-all.sh

echo "Finished configuring fresh install..."