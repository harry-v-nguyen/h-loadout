#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing typora..."

remove_pkg "typora"
