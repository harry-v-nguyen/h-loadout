#!/usr/bin/env bash
set -e

# ----------------------------------------
# Dotfiles setup script (Bash & Neovim)
# Assumes repo root if no path is provided
# ----------------------------------------

DEFAULT_REPO="$(pwd)/configurations"
REPO="${1:-$DEFAULT_REPO}"

BASHRC_TARGET="$HOME/.bashrc"
NVIM_TARGET="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/backup"

# ----------------------------------------
# Safety check
# ----------------------------------------
echo "Checking configuration path..."
if [[ ! -d "$REPO" ]]; then
    echo "Error: Provided path '$REPO' does not exist."
    echo "Tip: Run this script from the root of the repository without parameters."
    exit 1
fi
echo "Using repository path: $REPO"
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
echo ""

# ----------------------------------------
# Create symlinks
# ----------------------------------------
echo "Creating symlinks..."
ln -sf "$REPO/.bashrc" "$BASHRC_TARGET"
ln -sf "$REPO/nvim" "$NVIM_TARGET"

echo ""
echo "Symlinks created successfully!"
echo "	~/.bashrc → $REPO/.bashrc"
echo "	~/.config/nvim → $REPO/nvim"
echo ""

# ----------------------------------------
# Post-checks
# ----------------------------------------
if [[ -L "$BASHRC_TARGET" && -L "$NVIM_TARGET" ]]; then
    echo "Verification complete: both symlinks are valid."
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

