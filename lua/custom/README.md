# VSCode-like Configuration for Neovim

This configuration enhances Neovim to be more like VSCode, making it easier to use and more familiar for VSCode users.

## Features Added

### Visual Enhancements
- **VSCode Color Scheme**: Uses the `vscode.nvim` theme for a familiar look and feel
- **File Explorer**: Press `Ctrl+b` to toggle the file explorer (like VSCode)
- **Status Line**: Enhanced status line with git information, file path, and more
- **Indentation Guides**: Visual guides for code indentation
- **Relative Line Numbers**: Makes it easier to navigate with relative jumps

### Editing Features
- **Auto-pairs**: Automatically pairs brackets, quotes, etc.
- **Multiple Cursors**: Use `Ctrl+n` to select multiple occurrences (like VSCode's multi-cursor)

### Development Tools
- **Git Integration**: Shows git changes in the gutter and provides commands for working with git
- **Integrated Terminal**: Press ``Ctrl+` `` to toggle a floating terminal
- **Search and Replace**: Press `<leader>S` to open a powerful search and replace interface
- **Linting**: Automatic linting for various languages

## Key Bindings

### General
- `Space` - Leader key (used for many commands)
- `Ctrl+b` - Toggle file explorer
- ``Ctrl+` `` - Toggle terminal
- `<leader>S` - Open search and replace

### Navigation
- `Ctrl+h/j/k/l` - Navigate between splits
- Relative line numbers make it easy to jump with `{count}j` or `{count}k`

### Git
- `]c` / `[c` - Jump to next/previous git change
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hb` - Blame line
- `<leader>hp` - Preview hunk

### Terminal
- `Esc` - Exit terminal mode
- `Ctrl+h/j/k/l` - Navigate from terminal to other windows

## Installation Notes

This configuration assumes you have:

1. A Nerd Font installed and selected in your terminal (for icons)
2. Basic dependencies like git, ripgrep, etc. (see main README.md)

When you first start Neovim after these changes, it will automatically install all the required plugins. This might take a few minutes.

## Customization

You can further customize this setup by:

1. Editing `lua/custom/plugins/vscode.lua` to add or modify plugins
2. Adjusting keybindings to your preference
3. Adding more VSCode-like features as needed

Enjoy your enhanced Neovim experience!