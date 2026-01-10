#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing kdenlive..."

remove_pkg "kdenlive"
