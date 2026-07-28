# Neovim Config — VS Code Experience on Neovim

A modular Neovim configuration designed for developers coming from VS Code. Everything should feel familiar while embracing Neovim's strengths.

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── core/                   # Core settings
│   │   ├── options.lua         # Editor options
│   │   ├── keymaps.lua         # Core keymaps
│   │   ├── autocmds.lua        # Autocommands
│   │   └── vscode-keybindings.lua  # VS Code compatible keybindings
│   └── plugins/                # Plugin configs (auto-loaded by lazy.nvim)
│       ├── init.lua            # Plugin list / imports
│       ├── telescope.lua       # Fuzzy finder
│       ├── lsp.lua             # LSP (lspconfig, mason, formatters)
│       ├── blink.lua           # Autocompletion
│       ├── neo-tree.lua        # File explorer (sidebar)
│       ├── treesitter.lua      # Syntax highlighting
│       ├── conform.lua         # Format on save
│       ├── toggleterm.lua      # Integrated terminal
│       ├── gitsigns.lua        # Git signs in gutter
│       ├── lualine.lua         # Status line
│       ├── bufferline.lua      # Tab bar
│       ├── which-key.lua       # Keybinding hints
│       ├── trouble.lua         # Diagnostics panel
│       ├── noice.lua           # Modern UI (cmdline, messages)
│       ├── notify.lua          # Notification system
│       ├── dashboard.lua       # Welcome screen
│       ├── persistence.lua     # Session management
│       ├── todo-comments.lua   # TODO/FIXME highlighting
│       ├── flash.lua           # Motion navigation
│       ├── mini.lua            # Text objects, surround, pairs, statusline
│       ├── comment.lua         # Comment toggling
│       ├── spectre.lua         # Search & replace across files
│       ├── project.lua         # Project management
│       ├── colorscheme.lua     # Color schemes & theme switcher
│       ├── indent-blankline.lua # Indentation guides
│       └── extra.lua           # DAP, neogit, outline, multicursor
└── lazy-lock.json              # Plugin lockfile
```

## VS Code Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+S` | Save |
| `Ctrl+Z` | Undo |
| `Ctrl+Y` | Redo |
| `Ctrl+X` | Cut |
| `Ctrl+C` | Copy |
| `Ctrl+V` | Paste |
| `Ctrl+A` | Select all |
| `Ctrl+P` | Quick open files |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+F` | Find in file |
| `Ctrl+Shift+F` | Find in files |
| `Ctrl+H` | Replace in files |
| `Ctrl+B` | Toggle file explorer |
| `Ctrl+Shift+E` | Focus explorer |
| `Ctrl+`` ` | Toggle terminal |
| `Ctrl+/` | Toggle comment |
| `Ctrl+D` | Multi-cursor select next |
| `F2` | Rename symbol |
| `F12` | Go to definition |
| `Shift+F12` | Find references |
| `Alt+Up/Down` | Move line up/down |
| `Alt+Shift+F` | Format document |

## Leader Keybindings

| Key | Action |
|-----|--------|
| `<space>ff` | Find files |
| `<space>fg` | Live grep |
| `<space>fb` | Buffers |
| `<space>sh` | Search help |
| `<space>sk` | Search keymaps |
| `<space>e` | Toggle file explorer |
| `<space>xx` | Toggle trouble (diagnostics) |
| `<space>gg` | Open git UI (neogit) |
| `<space>S` | Search & replace (spectre) |
| `<space>pp` | Project switcher |
| `<space>qs` | Restore session |
| `<space>tt` | Theme picker |
| `<space>f` | Format buffer |

## LSP Mappings

| Key | Action |
|-----|--------|
| `grd` | Go to definition |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grn` | Rename |
| `gra` | Code action |
| `K` | Hover documentation |
| `gO` | Document symbols |
| `gW` | Workspace symbols |

## Theme Switching

| Key | Theme |
|-----|-------|
| `<space>tt` | Theme picker (Telescope) |
| `<space>tv` | VSCode |
| `<space>to` | Tokyo Night |
| `<space>tc` | Catppuccin |
| `<space>tg` | Gruvbox (default) |
| `<space>tD` | Dracula |
| `<space>tn` | Nord |

## Installation

```sh
git clone https://github.com/YOUR_USER/nvim-config.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

Requires: Neovim 0.10+, git, ripgrep, a Nerd Font, and language-specific tooling (go, rust, node, etc.) for LSP support.
