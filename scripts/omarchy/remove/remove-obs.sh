#!/usr/bin/env bash

set -e

echo "Removing obs..."

yay -Rns --noconfirm --needed obs
