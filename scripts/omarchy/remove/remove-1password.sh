#!/usr/bin/env bash

set -e

echo "Removing 1password-beta..."

yay -Rns --noconfirm --needed 1password-beta

echo "Removing 1password-cli..."

yay -Rns --noconfirm --needed 1password-cli
