#!/usr/bin/env bash

set -e

echo "Installing batctl-tui..."

~/.local/share/omarchy/bin/omarchy-pkg-aur-add "batctl-tui"
~/.local/share/omarchy/bin/omarchy-pkg-add "linux-headers"
~/.local/share/omarchy/bin/omarchy-pkg-aur-add "acer-wmi-battery-dkms"

sudo modprobe acer-wmi-battery

sudo batctl set --stop 80
sudo batctl persist enable
