#!/usr/bin/env bash
set -e

# ----------------------------------------
# Dotfiles setup script
# Assumes repo root if no path is provided
# ----------------------------------------

DEFAULT_CONFIG="$(pwd)/configurations"
CONFIG="${1:-$DEFAULT_CONFIG}"

BASHRC_TARGET="$HOME/.bashrc"
NVIM_TARGET="$HOME/.config/nvim"
GHOSTTY_TARGET="$HOME/.config/ghostty"
BACKUP_DIR="$HOME/.config/backup"

# ----------------------------------------
# Safety check
# ----------------------------------------
echo "Checking configuration path..."
if [[ ! -d "$CONFIG" ]]; then
    echo "Error: Provided path '$CONFIG' does not exist."
    echo "Tip: Run this script from the root of the repository without parameters."
    exit 1
fi
echo "Using repository path: $CONFIG"
echo ""

# ----------------------------------------
# Backup existing configurations
# ----------------------------------------
echo "Backing up existing configs to $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

if [[ -f "$BASHRC_TARGET" ]]; then
    mv "$BASHRC_TARGET" "$BACKUP_DIR/bashrc.backup" 2>/dev/null || true
    echo "Backed up existing .bashrc"
else
    echo "No existing .bashrc found."
fi

if [[ -d "$NVIM_TARGET" ]]; then
    mv "$NVIM_TARGET" "$BACKUP_DIR/nvim.backup" 2>/dev/null || true
    echo "Backed up existing nvim config."
else
    echo "No existing nvim config found."
fi

if [[ -d "$GHOSTTY_TARGET" ]]; then
    mv "$GHOSTTY_TARGET" "$BACKUP_DIR/ghostty.backup" 2>/dev/null || true
    echo "Backed up existing ghostty config."
else
    echo "No existing ghostty config found."
fi
echo ""

# ----------------------------------------
# Create symlinks
# ----------------------------------------
echo "Creating symlinks..."
ln -sf "$CONFIG/.bashrc" "$BASHRC_TARGET"
ln -sf "$CONFIG/nvim" "$NVIM_TARGET"
ln -sf "$CONFIG/ghostty" "$GHOSTTY_TARGET"

echo ""
echo "Symlinks created successfully!"
echo "	~/.bashrc → $CONFIG/.bashrc"
echo "	~/.config/nvim → $CONFIG/nvim"
echo "	~/.config/ghostty → $CONFIG/ghostty"
echo ""

# ----------------------------------------
# Post-checks
# ----------------------------------------
if [[ -L "$BASHRC_TARGET" && -L "$NVIM_TARGET" ]&& -L "$GHOSTTY_TARGET" ]; then
    echo "Verification complete: all symlinks are valid."
else
    echo "Warning: One or more symlinks may not have been created correctly."
fi
echo ""

# ----------------------------------------
# Done
# ----------------------------------------
echo "Dotfile setup complete!"
echo "Backups stored in: $BACKUP_DIR"
echo "Tip: Run this script from the repo root if no path is provided."
echo ""

