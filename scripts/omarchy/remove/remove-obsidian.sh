#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing obsidian..."

remove_pkg "obsidian"
