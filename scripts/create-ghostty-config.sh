#!/usr/bin/env bash
set -e

# ----------------------------------------
# Ghostty Config Creation Script
# Creates a Ghostty config file
#
# Assumes repo root if no path is provided.
# ----------------------------------------

DEFAULT_REPO="$(pwd)"
REPO_ROOT="${1:-$DEFAULT_REPO}"

CONFIG_DIR="$REPO_ROOT/configurations/ghostty"
CONFIG_FILE="$CONFIG_DIR/config"
IMAGE_PATH="$REPO_ROOT/images/Urahara Wallpaper.png"

# ----------------------------------------
# Preparation
# ----------------------------------------
echo "Initializing Ghostty config creation..."
if [[ ! -d "$REPO_ROOT" ]]; then
    echo "Error: Provided path '$REPO_ROOT' does not exist."
    echo "Tip: Run this script from the root of the repository without parameters."
    exit 1
fi

if [[ ! -f "$IMAGE_PATH" ]]; then
    echo "Warning: Image not found at expected location:"
    echo "  $IMAGE_PATH"
    echo "The background setting will still be written."
    echo ""
fi

echo "Using repository path: $REPO_ROOT"
mkdir -p "$CONFIG_DIR"
echo "Ensured config directory exists: $CONFIG_DIR"
echo ""

# ----------------------------------------
# Create Config File (Single Write)
# ----------------------------------------
echo "Creating Ghostty config file at: $CONFIG_FILE"
cat > "$CONFIG_FILE" <<EOF
# This is the configuration file for Ghostty.
#
# This template file has been automatically created at the following
# path since Ghostty couldn't find any existing config files on your system:
#
# The template does not set any default options, since Ghostty ships
# with sensible defaults for all options. Users should only need to set
# options that they want to change from the default.
#
# Run \`ghostty +show-config --default --docs\` to view a list of
# all available config options and their default values.
#
# Additionally, each config option is also explained in detail
# on Ghostty's website, at https://ghostty.org/docs/config.
#
# Ghostty can reload the configuration while running by using the menu
# options or the bound key (default: Command + Shift + comma on macOS and
# Control + Shift + comma on other platforms). Not all config options can be
# reloaded while running; some only apply to new windows and others may require
# a full restart to take effect.

# Config syntax crash course
# ==========================
# # The config file consists of simple key-value pairs,
# # separated by equals signs.
# font-family = Iosevka
# window-padding-x = 2
#
# # Spacing around the equals sign does not matter.
# # All of these are identical:
# key=value
# key= value
# key =value
# key = value
#
# # Any line beginning with a # is a comment. It's not possible to put
# # a comment after a config option, since it would be interpreted as a
# # part of the value. For example, this will have a value of "#123abc":
# background = #123abc
#
# # Empty values are used to reset config keys to default.
# key =
#
# # Some config options have unique syntaxes for their value,
# # which is explained in the docs for that config option.
# # Just for example:
# resize-overlay-duration = 4s 200ms

background-image = "${IMAGE_PATH}"
background-image-fit = cover
background-image-opacity = 0.1
background-opacity = 1

theme = "Catppuccin Mocha"

font-family = "JetBrainsMono Nerd Font Propo"
font-size = 16
font-style = Regular

keybind = ctrl+shift+c=copy_to_clipboard
keybind = ctrl+shift+v=paste_from_clipboard
EOF

# ----------------------------------------
# Post-Checks
# ----------------------------------------
if [[ -f "$CONFIG_FILE" ]]; then
    echo "Config file created successfully!"
    echo "Location: $CONFIG_FILE"
    echo "Background set to: $IMAGE_PATH"
else
    echo "Failed to create config file."
    exit 1
fi
echo ""

# ----------------------------------------
# Done
# ----------------------------------------
echo "Ghostty configuration setup complete!"
echo "Tip: To reload config in Ghostty, press Ctrl + Shift + ,"
echo ""
