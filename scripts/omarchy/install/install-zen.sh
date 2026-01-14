#!/usr/bin/env bash

set -e

echo "Installing zen-browser-bin..."

yay -Syu --noconfirm --needed zen-browser-bin

xdg-settings set default-web-browser zen.desktop
