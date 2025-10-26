#!/usr/bin/env bash

set -euo pipefail
# -e : exit immediately on error
# -u : treat unset variables as errors
# -o pipefail : fail if any command in a pipeline fails

# Arch Linux post-install setup script
# Run as a user with sudo privileges

# --------------------------
# Safety & environment checks
# --------------------------
if ! grep -q "^ID=arch$" /etc/os-release; then
    echo "Warning: This script is intended for Arch Linux. Exiting."
    exit 1
fi

if [[ $EUID -ne 0 ]]; then
  echo "This script requires sudo privileges. You may be prompted for your password."
fi

# --------------------------
# NVIDIA Drivers
# --------------------------
echo "Removing old NVIDIA drivers..."
sudo pacman -Rns --noconfirm nvidia nvidia-utils

echo "Installing new NVIDIA drivers..."
sudo pacman -S --noconfirm nvidia-open nvidia-utils

echo "Regenerating initramfs..."
sudo mkinitcpio -P

echo "Reboot recommended after NVIDIA driver installation"
# sudo reboot   # Uncomment to reboot automatically

# --------------------------
# Bluetooth setup
# --------------------------
echo "Installing Bluetooth packages..."
sudo pacman -S --noconfirm bluez bluez-utils

echo "Starting and enabling Bluetooth service..."
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

# --------------------------
# Browser (AUR)
# --------------------------
echo "Installing Zen Browser (yay AUR package)..."
yay -S --noconfirm zen-browser-bin

# --------------------------
# BIOS / Utilities
# --------------------------
echo "Installing dosfstools for BIOS updates (ASRock Instant Flash)..."
sudo pacman -S --noconfirm dosfstools

# --------------------------
# Audio tweaks (manual)
# --------------------------
echo "NOTE: Manual edits may be required for audio power settings"
echo "You may need to add the following lines to /etc/modprobe.d/disable_usb_audio_power.conf:"
echo "options snd_usb_audio power_save=0"
echo "options snd_hda_intel power_save=0"
echo "options snd_usb_audio device_setup=1"

# Uncomment lines to do automatically:
# echo "Applying audio power settings..."
# AUDIO_CONF="/etc/modprobe.d/disable_usb_audio_power.conf"
# sudo tee $AUDIO_CONF > /dev/null <<EOF
# options snd_usb_audio power_save=0
# options snd_hda_intel power_save=0
# options snd_usb_audio device_setup=1
# EOF
# echo "Audio tweaks applied to $AUDIO_CONF"

# --------------------------
# Mouse / Razer setup
# --------------------------
echo "Installing OpenRazer and Polychromatic..."
yay -S --noconfirm openrazer-meta-git polychromatic

echo "Adding user to plugdev group..."
sudo gpasswd -a $USER plugdev

echo "Installing Linux headers for DKMS..."
sudo pacman -S --noconfirm linux-headers

echo "Installing OpenRazer DKMS driver..."
sudo dkms install -m openrazer-driver/3.10.3

echo "Loading Razer keyboard module..."
sudo modprobe razerkbd

# --------------------------
# Video player
# --------------------------
echo "Installing Celluloid media player..."
sudo pacman -S --noconfirm celluloid

# --------------------------
# Enable multilib repository (manual)
# --------------------------
echo "NOTE: You need to manually enable [multilib] in /etc/pacman.conf"
echo "Uncomment the lines:"
echo "[multilib]"
echo "Include = /etc/pacman.d/mirrorlist"

# Uncomment lines to do automatically:
# PACMAN_CONF="/etc/pacman.conf"
# if ! grep -q "^\[multilib\]" $PACMAN_CONF; then
#   echo "Enabling [multilib] repository..."
#   sudo sed -i '/#\[multilib\]/{s/#//; n; s/#//}' $PACMAN_CONF
#   echo "[multilib] enabled in $PACMAN_CONF"
#   sudo pacman -Sy
# fi

# --------------------------
# Steam
# --------------------------
echo "Installing Steam..."
sudo pacman -S --noconfirm steam

# --------------------------
# Benchmarks
# --------------------------
echo "Installing Phoronix Test Suite..."
yay -S --noconfirm phoronix-test-suite

echo "Installing MangoHud..."
sudo pacman -S --noconfirm mangohud

# --------------------------
# Auto-complete / Zsh
# --------------------------
echo "Installing Zsh and Oh My Zsh..."
sudo pacman -S --noconfirm zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Zsh autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing Pygments for syntax highlighting in Zsh..."
sudo pacman -S --noconfirm python-pygments

# --------------------------
# OpenRGB (RGB lighting control)
# --------------------------
echo "Installing OpenRGB..."
yay -S --noconfirm openrgb

# --------------------------
# Tmux
# --------------------------
echo "Installing tmux..."
sudo pacman -S --noconfirm tmux

# --------------------------
# Firmware update utility
# --------------------------
echo "Installing fwupd for firmware management..."
sudo pacman -S --noconfirm fwupd

# --------------------------
# Done
# --------------------------
echo "------------------------------------------------------"
echo "Setup script completed!"
echo "Review any manual steps (e.g., NVIDIA reboot, Oh My Zsh setup)."
echo "Enjoy your Arch environment!"
echo ""

