#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing omarchy-chromium..."

remove_pkg "omarchy-chromium"
