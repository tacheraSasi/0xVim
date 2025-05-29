# How to Use Your VSCode-like Neovim Setup

This is a quick guide to help you get started with your Neovim configuration that mimics VSCode.

## Getting Started

1. Start Neovim by typing `nvim` in your terminal
2. The first time you start, plugins will automatically install (wait for this to complete)
3. Use `Space` as your leader key for many commands

## Essential Keybindings

### Basic Navigation
- `h/j/k/l` - Move cursor left/down/up/right
- `Ctrl+h/j/k/l` - Navigate between split windows
- `{number}j` or `{number}k` - Jump multiple lines down/up

### File Management
- `Ctrl+b` - Toggle file explorer
- `pace+sf` - Search for files
- `Space+sg` - Search in files (grep)

### Coding
- `Tab` - Accept completion suggestion
- `Ctrl+n` - Start multiple cursor selection
- `Space+f` - Format current file

### Terminal
- ``Ctrl+` `` - Toggle terminal
- `Esc` - Exit terminal mode

### Git
- `]c` / `[c` - Jump to next/previous git change
- `Space+hs` - Stage current hunk
- `Space+hp` - Preview git changes

### Themes

This configuration comes with two themes:
- **VSCode Theme** (default): Mimics the look and feel of VSCode
- **Original Theme** (tokyonight-night): The classic Neovim theme

To switch between themes:
- `Space+to` - Switch to the [O]riginal theme (tokyonight-night)
- `Space+tv` - Switch to the [V]SCode theme

## Tips for New Users

1. Press `Space` and wait to see available commands
2. Use `:help` for Neovim's built-in documentation
3. Most VSCode keyboard shortcuts have equivalents
4. For more details, see the full documentation in `lua/custom/README.md`

Enjoy your enhanced Neovim experience!
