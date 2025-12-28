#!/usr/bin/env bash

set -e

echo "Setting up dotfiles..."

# bash
target="$HOME/.bashrc"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# desktop background
target="$HOME/.config/omarchy/current/theme/backgrounds/Abstract Background 3.png"
[ -e "$target" ] || ln -s "$PWD/images/Abstract Background 3.png" "$target"

# ghostty
target="$HOME/.config/ghostty/config"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# ghostty background
mkdir -p "$HOME/Pictures/Backgrounds"
target="$HOME/Pictures/Backgrounds/Urahara Background.png"
[ -e "$target" ] || ln -s "$PWD/images/Urahara Background.png" "$target"

# inputs
target="$HOME/.config/hypr/input.conf"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# nvim
rm -rf "$HOME/.local/share/nvim/" "$HOME/.cache/nvim/"
target="$HOME/.config/nvim"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target-bak"

# screensaver
target="$HOME/.config/omarchy/branding/screensaver.txt"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# starship
target="$HOME/.config/starship.toml"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# tmux
target="$HOME/.tmux.conf"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# waybar
target="$HOME/.config/waybar/config.jsonc"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

stow -d configurations -t "$HOME" $(ls configurations)
