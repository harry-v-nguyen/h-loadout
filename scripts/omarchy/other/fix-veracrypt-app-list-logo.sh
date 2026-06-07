#!/usr/bin/env bash

set -e

echo "Fixing VeraCrypt app icon..."

mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/256x256/apps

icon_path="$(find /usr/share/icons /usr/share/pixmaps ~/.local/share/icons \
  -type f \( -iname "*veracrypt*.png" -o -iname "*veracrypt*.svg" -o -iname "*veracrypt*.xpm" \) \
  2>/dev/null | head -n 1)"

if [ -z "$icon_path" ]; then
  echo "No VeraCrypt icon image found."
  exit 1
fi

cp "$icon_path" ~/.local/share/icons/hicolor/256x256/apps/veracrypt."${icon_path##*.}"

cp /usr/share/applications/veracrypt.desktop ~/.local/share/applications/veracrypt.desktop

sed -i 's|^Icon=.*|Icon=veracrypt|' ~/.local/share/applications/veracrypt.desktop

gtk-update-icon-cache ~/.local/share/icons/hicolor 2>/dev/null || true
update-desktop-database ~/.local/share/applications 2>/dev/null || true

echo "VeraCrypt app icon fixed."
