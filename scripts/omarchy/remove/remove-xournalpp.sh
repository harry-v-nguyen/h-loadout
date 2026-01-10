#!/usr/bin/env bash

set -e

source ./scripts/omarchy/remove/utils.sh

echo "Removing xournalpp..."

remove_pkg "xournalpp"
