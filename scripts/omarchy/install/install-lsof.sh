#!/usr/bin/env bash

set -e

echo "Installing lsof..."

yay -Syu --noconfirm --needed lsof
