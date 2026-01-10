#!/usr/bin/env bash

remove_pkg() {
    if pacman -Qi "$1" > /dev/null 2>&1; then
        yay -Rns --noconfirm "$1"
    else
        echo "Skipping $1 (not found)."

        return 0
    fi
}
