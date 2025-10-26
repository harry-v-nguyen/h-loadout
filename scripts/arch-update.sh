#!/usr/bin/env bash

# Arch Linux system & firmware update script
# Run as a user with sudo privileges

# --------------------------
# Safety check: ensure Arch Linux
# --------------------------
if ! grep -q "^ID=arch$" /etc/os-release; then
    echo "Warning: This script is intended for Arch Linux. Exiting."
    exit 1
fi

# --------------------------
# Update system packages
# --------------------------
echo "Updating system packages (yay -Syu)..."
yay -Syu --noconfirm
echo ""

# --------------------------
# Clean package cache
# --------------------------
echo "Cleaning package cache..."
yay -Sc --noconfirm
echo ""

# --------------------------
# Remove orphaned packages
# --------------------------
echo "Removing orphaned packages..."
ORPHANS=$(pacman -Qdtq)
if [[ -n "$ORPHANS" ]]; then
    echo "Orphaned packages found:"
    echo "$ORPHANS"
    sudo pacman -Rns $ORPHANS
else
    echo "No orphaned packages found."
fi
echo ""

# --------------------------
# Check for failed services
# --------------------------
echo "Checking for failed systemd services..."
FAILED_SERVICES=$(systemctl --failed --no-legend | awk '{print $1}')
if [[ -n "$FAILED_SERVICES" ]]; then
    echo "Failed services detected:"
    echo "$FAILED_SERVICES"
else
    echo "No failed services detected."
fi
echo ""

# --------------------------
# Firmware updates (safe, manual)
# --------------------------
echo "Refreshing LVFS (fwupd) metadata..."
sudo fwupdmgr refresh
echo ""

echo "Checking for available firmware updates..."
FWUPD_OUTPUT=$(fwupdmgr get-updates 2>/dev/null)

# Separate critical (BIOS/GPU/UEFI/Video) and non-critical updates
CRITICAL=$(echo "$FWUPD_OUTPUT" | grep -E 'BIOS|UEFI|GPU|Video')

# Remove lines related to "Devices with no available firmware updates"
NON_CRITICAL=$(echo "$FWUPD_OUTPUT" | grep -v -E 'BIOS|UEFI|GPU|Video|Devices with no available firmware updates|•')

# Extract devices with no available firmware updates
NO_UPDATES=$(echo "$FWUPD_OUTPUT" | sed -n '/Devices with no available firmware updates:/,/^$/p' | grep "•")

# Output for clarity
echo ""
echo ""
echo ""
echo ""
echo ""
echo "================ Firmware Updates ================="
echo ""

echo "Raw Output:"
echo "$FWUPD_OUTPUT"
echo ""

echo "Critical updates (BIOS/GPU/UEFI/Video):"
if [[ -n "$CRITICAL" ]]; then
    echo "$CRITICAL"
else
    echo "None"
fi
echo ""

echo "Non-critical updates (peripherals, devices, etc.):"
if [[ -n "$NON_CRITICAL" ]]; then
    echo "$NON_CRITICAL"
else
    echo "None"
fi
echo ""

# --- Devices with no updates ---
if [[ -n "$NO_UPDATES" ]]; then
    echo "Devices with no available firmware updates:"
    echo "$NO_UPDATES"
    echo ""
fi

echo "To install all available updates manually, run:"
echo "    sudo fwupdmgr update"
echo ""
echo "To install a single update for a specific device, run:"
echo "    sudo fwupdmgr update <DeviceID>"
echo "Example: sudo fwupdmgr update USB:1234"
echo ""
echo "Review each device carefully before updating, especially critical updates."
echo ""
echo "=================================================="
echo ""

# --------------------------
# Recommend reboot if kernel updated
# --------------------------
if grep -E "(upgraded|installed) (linux|linux-[a-z]+)" /var/log/pacman.log | tail -n 1 | grep -q "$(date +%Y-%m-%d)"; then
    echo "A kernel package was updated. Reboot recommended."
else
    echo "No kernel updates detected. No reboot needed."
fi
echo ""

# --------------------------
# Done
# --------------------------
echo "System and firmware update checks completed!"
echo "Review firmware updates manually as instructed above."
echo ""

