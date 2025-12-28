#!/usr/bin/env bash

set -e

echo "Setting up dotfiles..."

# bash
target="$HOME/.bashrc"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# nvim
rm -rf "$HOME/.local/share/nvim/" "$HOME/.cache/nvim/"
target="$HOME/.config/nvim"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target-bak"

# starship
target="$HOME/.config/starship.toml"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

# tmux
target="$HOME/.tmux.conf"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"

stow -d configurations -t "$HOME" bash nvim starship tmux
