#!/usr/bin/env bash

set -e

echo "Installing tmux..."

yay -Syu --noconfirm --needed tmux
