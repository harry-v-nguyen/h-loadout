#!/usr/bin/env bash

set -e

echo "Removing omarchy-chromium..."

yay -Rns --noconfirm --needed omarchy-chromium
