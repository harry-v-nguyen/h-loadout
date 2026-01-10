#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing alacritty..."

remove_pkg "alacritty"
