#!/usr/bin/env bash

set -e

echo "Sanitizing app list..."

echo "Removing broken user app launchers..."

find ~/.local/share/applications -name "*.desktop" 2>/dev/null | while read -r desktop_file; do
  exec_cmd="$(grep -m1 '^Exec=' "$desktop_file" | cut -d= -f2- | sed 's/ %.//g' | awk '{print $1}')"

  [ -z "$exec_cmd" ] && continue

  if ! command -v "$exec_cmd" >/dev/null 2>&1 && [ ! -x "$exec_cmd" ]; then
    echo "Removing stale launcher: $desktop_file"
    rm "$desktop_file"
  fi
done

echo "Removing broken local app launchers..."

find /usr/local/share/applications -name "*.desktop" 2>/dev/null | while read -r desktop_file; do
  exec_cmd="$(grep -m1 '^Exec=' "$desktop_file" | cut -d= -f2- | sed 's/ %.//g' | awk '{print $1}')"

  [ -z "$exec_cmd" ] && continue

  if ! command -v "$exec_cmd" >/dev/null 2>&1 && [ ! -x "$exec_cmd" ]; then
    echo "Removing stale launcher: $desktop_file"
    sudo rm "$desktop_file"
  fi
done

echo "Removing Omarchy web app launchers..."

find ~/.local/share/applications -name "*.desktop" 2>/dev/null | while read -r desktop_file; do
  if grep -qiE 'omarchy|webapp|web-app|--app=|app-id|chrome.*app|chromium.*app' "$desktop_file"; then
    echo "Removing web app launcher: $desktop_file"
    rm "$desktop_file"
  fi
done

echo "Updating desktop database..."

~/.local/share/omarchy/bin/omarchy-pkg-add "desktop-file-utils"

update-desktop-database ~/.local/share/applications 2>/dev/null || true
sudo update-desktop-database /usr/local/share/applications 2>/dev/null || true
sudo update-desktop-database /usr/share/applications 2>/dev/null || true

echo "App list sanitized."
