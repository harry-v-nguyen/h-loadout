#!/usr/bin/env bash

set -e

echo "Removing signal..."

yay -Rns --noconfirm --needed signal
