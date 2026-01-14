#!/usr/bin/env bash

set -e

echo "Installing bash-completion..."

yay -Syu --noconfirm --needed bash-completion
