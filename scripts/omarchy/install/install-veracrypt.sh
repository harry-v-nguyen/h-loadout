#!/usr/bin/env bash

set -e

echo "Installing veracrypt..."

yay -Syu --noconfirm --needed veracrypt
