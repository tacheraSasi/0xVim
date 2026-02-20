# How to Use Your Enhanced Neovim Setup

This is a comprehensive guide to help you get started with your Neovim configuration.

> [!TIP]
> **New Users:**
> - 🍎 Coming from Mac? See [MAC_INSTALLATION.md](MAC_INSTALLATION.md)
> - 🔄 Coming from VSCode? See [VSCODE_MIGRATION.md](VSCODE_MIGRATION.md)
> - 🎨 Want to customize themes? See [THEMES.md](THEMES.md)

## Quick Start: Getting Help

**NEW**: Press `<leader>?` or `F1` at any time to open the **How-To Modal** - a comprehensive floating window with all available commands and shortcuts organized by category!

## Getting Started

1. Start Neovim by typing `nvim` in your terminal
2. The first time you start, plugins will automatically install (wait for this to complete)
3. Use `Space` as your leader key for many commands

## File Explorer Sidebar

The sidebar file explorer (Neo-tree) can be toggled with:
- `Ctrl+B` - Toggle sidebar (VSCode-style)
- `Ctrl+Shift+E` - Toggle sidebar (alternative)

**Inside Neo-tree:**
- `<Enter>` - Open file
- `<Space>` - Expand/collapse folder
- `a` - Create new file
- `A` - Create new directory
- `d` - Delete file/folder
- `r` - Rename file/folder
- `y` - Copy to clipboard
- `x` - Cut to clipboard
- `p` - Paste from clipboard
- `H` - Toggle hidden files
- `R` - Refresh
- `?` - Show help

## Essential Keybindings

### Basic Navigation
- `h/j/k/l` - Move cursor left/down/up/right
- `Ctrl+h/j/k/l` - Navigate between split windows
- `{number}j` or `{number}k` - Jump multiple lines down/up
- `s` - Flash jump (enhanced search)
- `S` - Flash treesitter jump
- `r` - Remote flash jump
- `R` - Treesitter search

### Window Management
- `<leader>w` - Window operations
- `<leader>ww` - Next window
- `<leader>wd` - Delete window
- `<leader>w-` - Split window horizontally
- `<leader>w|` - Split window vertically

### Buffer Management
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer

### File Management
- `<leader>sf` - Search for files
- `<leader>sg` - Search in files (grep)
- `<leader>sw` - Search current word
- `<leader>sd` - Search diagnostics
- `<leader>sr` - Resume last search
- `<leader>s.` - Search recent files
- `<leader><leader>` - Find existing buffers
- `Ctrl+B` - Toggle file explorer sidebar
- `Ctrl+Shift+E` - Toggle file explorer sidebar (alternative)
- `Ctrl+P` - Quick open files (fuzzy finder)
- `Ctrl+S` - Save current file
- `Ctrl+Shift+S` - Save all files

### Code Navigation
- `grn` - Rename symbol
- `gra` - Code actions
- `grr` - Find references
- `gri` - Go to implementation
- `grd` - Go to definition
- `grD` - Go to declaration
- `gO` - Open document symbols
- `gW` - Open workspace symbols
- `grt` - Go to type definition

### Diagnostics and Troubleshooting
- `<leader>xx` - Toggle Trouble window
- `<leader>xw` - Workspace diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xq` - Quickfix list
- `<leader>xl` - Location list
- `<leader>xt` - View TODO comments
- `<leader>xT` - Search TODO comments

### Code Editing
- `<leader>f` - Format current file
- `<A-j>/<A-k>` - Move lines up/down
- `v` + `<` or `>` - Indent selection
- `Tab` - Accept completion suggestion
- `<C-space>` - Show completion menu
- `<C-k>` - Toggle signature help

### Git Integration
- `]c` / `[c` - Jump to next/previous git change
- `<leader>hs` - Stage current hunk
- `<leader>hp` - Preview git changes

### Terminal
- `` Ctrl+` `` - Toggle terminal
- `Esc` - Exit terminal mode

### Themes

0xVim includes 10+ beautiful themes with 30+ variants:
- **VSCode**, **Tokyo Night**, **Catppuccin**, **Dracula**, **Nord**, **Gruvbox**, and more!

Quick theme switching:
- `<leader>tt` - Interactive theme picker with live preview
- `<leader>tv` - VSCode theme
- `<leader>to` - Tokyo Night theme
- `<leader>tc` - Catppuccin theme
- `<leader>tD` - Dracula theme
- `<leader>tn` - Nord theme
- `<leader>tg` - Gruvbox theme

> [!TIP]
> **For complete theme documentation with all variants and customization options, see [THEMES.md](THEMES.md)**

## Additional Features

### Code Intelligence
- Automatic LSP setup for multiple languages
- Intelligent code completion
- Inline diagnostics
- Code actions and refactoring
- Symbol search and navigation
- Inlay hints (toggle with `<leader>th`)

### Editor Enhancements
- Persistent undo history
- Smart case-insensitive search
- Live preview of substitutions
- Better indentation handling
- Improved window and buffer management
- Enhanced search functionality

### Plugin Features
- **Trouble.nvim**: Better diagnostics and quickfix
- **Todo-comments**: Highlight and search TODO comments
- **Which-key**: Shows available keybindings
- **Telescope**: Powerful fuzzy finder
- **Treesitter**: Better syntax highlighting
- **Flash.nvim**: Enhanced search and navigation
  
#### VSCode-like Import Handling
The configuration includes VSCode-like import handling for various languages:

- **TypeScript/JavaScript**: Auto-imports and organizes imports on save
- **Go**: Automatic import management with `gopls`
- **Python**: Auto-import completions with `pyright`
- **Rust**: Granular import management with `rust-analyzer`
- **Java**: Automatic import organization with `jdtls`

To organize imports manually, use:
- `<leader>i` - Organize imports in the current file
- Imports are also automatically organized on save

#### Line-based Indentation Visualization
The configuration uses line-based indentation visualization instead of the default `>>` markers. This provides a cleaner and more intuitive way to see code structure.


## Tips for New Users

1. **Forgotten a command?** Press `<leader>?` or `F1` to see the complete How-To guide
2. Press `Space` and wait to see available commands (which-key)
3. Use `:help` for Neovim's built-in documentation
4. Most modern editor keyboard shortcuts have equivalents
5. The sidebar file explorer opens with `Ctrl+B` (just like VSCode!)
6. For more details, see the full documentation in `lua/custom/README.md`

## Common Questions

**Q: How do I open the sidebar/file explorer?**
A: Press `Ctrl+B` or `Ctrl+Shift+E` - it will toggle the Neo-tree sidebar on the left.

**Q: I forgot a keyboard shortcut, what do I do?**
A: Press `<leader>?` (that's Space followed by ?) or simply press `F1` to see the comprehensive How-To guide.

**Q: How do I close a floating window?**
A: Most floating windows can be closed with `q` or `Esc`.

Enjoy your enhanced Neovim experience!
