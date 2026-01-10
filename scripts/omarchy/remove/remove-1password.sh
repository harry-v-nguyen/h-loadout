#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing 1password-beta..."

remove_pkg "1password-beta"

echo "Removing 1password-cli..."

remove_pkg "1password-cli"
