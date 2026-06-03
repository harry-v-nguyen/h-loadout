#!/usr/bin/env bash

set -e

echo "Installing zen-browser-bin..."

~/.local/share/omarchy/bin/omarchy-pkg-aur-add "zen-browser-bin"

xdg-settings set default-web-browser zen.desktop
