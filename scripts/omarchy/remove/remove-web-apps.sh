#!/usr/bin/env bash
set -e

echo "Removing web apps..."

apps=(
    "Basecamp" "ChatGPT" "Discord" "Figma" "Fizzy" "GitHub" 
    "Google Contacts" "Google Maps" "Google Messages" "Google Photos" 
    "HEY" "WhatsApp" "X" "YouTube" "Zoom"
)

~/.local/share/omarchy/bin/omarchy-webapp-remove "${apps[@]}"
