#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing obs-studio..."

remove_pkg "obs-studio"
