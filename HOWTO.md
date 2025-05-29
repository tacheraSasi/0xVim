# How to Use Your Enhanced Neovim Setup

This is a comprehensive guide to help you get started with your Neovim configuration.

## Getting Started

1. Start Neovim by typing `nvim` in your terminal
2. The first time you start, plugins will automatically install (wait for this to complete)
3. Use `Space` as your leader key for many commands

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

This configuration comes with the following themes:
- **tokyonight-night** (default): A beautiful dark theme
- **tokyonight-storm**: A stormy variant
- **tokyonight-moon**: A moonlit variant
- **tokyonight-day**: A light variant

To switch between themes:
- `<leader>tc` - Open theme selector

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

## Tips for New Users

1. Press `Space` and wait to see available commands
2. Use `:help` for Neovim's built-in documentation
3. Most modern editor keyboard shortcuts have equivalents
4. For more details, see the full documentation in `lua/custom/README.md`

Enjoy your enhanced Neovim experience!
