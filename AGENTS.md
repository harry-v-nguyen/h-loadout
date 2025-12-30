# Agent Guidelines for h-loadout

This repository is a dotfiles management system for Linux environments (Fedora, Omarchy distribution). It contains configuration files and installation scripts for various development tools.

## Build/Test Commands

This repository contains no build, lint, or test commands. Scripts are executed directly and configurations are managed via GNU Stow.

### Testing Shell Scripts
Run scripts directly to verify changes:
```bash
# Test specific scripts
./scripts/omarchy/install/install-go.sh
./scripts/omarchy/setup/setup-dotfiles.sh

# Test installation script with echo (dry-run simulation)
# Edit script to add "echo" before "yay" commands
```

### Testing Neovim Configurations
```bash
# Restart Neovim to load changes
nvim --headless "+Lazy! sync" +qa
# Check plugin health
:checkhealth lsp
```

## Shell Script Guidelines

### File Structure
- All scripts must use `#!/usr/bin/env bash` shebang
- Always include `set -e` at the top for error handling
- Use descriptive echo statements for progress tracking
- Keep scripts minimal and single-purpose

### Naming Conventions
- Install scripts: `install-{tool-name}.sh`
- Remove scripts: `remove-{tool-name}.sh`
- Setup scripts: `setup-{feature}.sh`
- Use lowercase with hyphens for file and directory names

### Code Style
```bash
#!/usr/bin/env bash

set -e

echo "Descriptive action message..."

# Install packages (yay for AUR on Omarchy/Arch)
yay -S --noconfirm --needed package-name

# Remove packages
yay -Rns --noconfirm --needed package-name

# Stow setup pattern
target="$HOME/.config/tool"
[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"
```

### Error Handling
- Always use `set -e` to exit on errors
- Check for existing files/directories before creating symlinks
- Backup existing non-symlinked files with `.bak` extension
- Pattern: `[ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.bak"`

### Package Management
- Use `yay` for AUR packages on Omarchy/Arch
- Use `dnf` for Fedora packages
- Always use flags: `--noconfirm --needed`
- For Go tools: `go install package@latest`

## Lua Configuration Guidelines (Neovim)

### File Organization
- Use modular structure in `lua/config/` and `lua/plugins/`
- Each plugin in separate file under `lua/plugins/`
- Require modules in `init.lua` with `require("config.module-name")`

### Code Style
```lua
return {
    "author/plugin-name",
    dependencies = { "dep1", "dep2" },
    config = function()
        -- Configuration code here
    end,
}
```

### Indentation and Formatting
- Use tab indentation only (no spaces), consistent with existing code
- Align tables vertically for readability
- Add comments for section headers using dashes

### Keybind Patterns
```lua
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
-- Descriptions use bracketed abbreviations
```

### LSP Configuration
- Define servers in `servers` table
- Use Mason for automatic installation
- Configure per-language settings in server-specific tables
- Attach keymaps in LspAttach autocmd

## Configuration File Guidelines

### Dotfiles Management
- Use GNU Stow to manage symlinks from `configurations/` to `$HOME`
- Maintain directory structure matching target paths under `.config/`
- Example: `configurations/nvim/.config/nvim/` → `$HOME/.config/nvim`

### Configuration Files
- **bash**: `.bashrc` for shell configuration
- **tmux**: `.tmux.conf` with clear section comments
- **starship**: `starship.toml` with schema validation
- **nvim**: Lua-based configuration, no comments unless asked
- **ghostty**: Terminal emulator configuration
- **waybar**: JSONC format for bar customization

## General Conventions

### File Paths
- Use absolute paths in scripts: `$HOME` or `~`
- Use relative paths for repository references: `$PWD` or `scripts/omarchy/...`

### Script Execution
- All scripts in `install/` are called by `install-all.sh`
- All scripts in `setup/` are called by `setup-all.sh`
- Fresh install uses pattern: remove-all.sh → install-all.sh → setup-all.sh

### Repository Structure
```
configurations/    # All dotfiles (stow targets)
scripts/          # Installation and setup scripts
  fedora/         # Fedora-specific scripts
  omarchy/        # Omarchy-distro specific scripts
images/           # Wallpapers and profile pictures
```

### Adding New Configurations
1. Create `configurations/tool-name/` directory mirroring target path (e.g., `.config/tool-name/`)
2. Create install/setup scripts in `scripts/{distro}/install/` and `scripts/{distro}/setup/`
3. Update corresponding `install-all.sh` or `setup-all.sh` if applicable

### Stow Usage
```bash
# Stow all configurations
stow -d configurations -t "$HOME" $(ls configurations)

# Stow specific configuration
stow -d configurations -t "$HOME" nvim
stow -d configurations -t "$HOME" tmux

# Restow (update existing)
stow -R -d configurations -t "$HOME" nvim
```

### Stow Troubleshooting
```bash
# Dry-run to preview changes
stow -n -d configurations -t "$HOME" nvim

# Verbose mode for debugging
stow -v -d configurations -t "$HOME" nvim

# List symlinks
stow -d configurations -t "$HOME" --no nvim
```
