# Neovim Config — VS Code Experience on Neovim

A modular Neovim configuration designed for developers coming from VS Code. Everything should feel familiar while embracing Neovim's strengths.

> **New here?** Read **[HOW_TO.md](HOW_TO.md)** — a full walk-through guide from install to daily usage.

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
│       ├── codediff.lua        # VSCode-style git diff & changes sidebar
│       ├── aicommits.lua       # AI commit messages (OpenCode Go)
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
| `Ctrl+Shift+S` | Save all |
| `Ctrl+Z` / `Ctrl+Y` | Undo / Redo |
| `Ctrl+X` / `Ctrl+C` / `Ctrl+V` | Cut / Copy / Paste |
| `Ctrl+A` | Select all |
| `Ctrl+P` | Quick open files |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+F` | Find in file |
| `Ctrl+R` | Replace in file |
| `Ctrl+Shift+F` | Find in files |
| `Ctrl+Shift+H` | Replace in files (Spectre) |
| `Ctrl+G` | Go to line |
| `Ctrl+B` | Toggle file explorer (right side) |
| `Ctrl+Shift+E` | Focus file explorer |
| `Ctrl+0` | Focus sidebar |
| `Ctrl+1` | Focus editor |
| `Ctrl+`` ` | Toggle terminal (float) |
| `Ctrl+/` | Toggle comment |
| `Ctrl+K Ctrl+C` / `Ctrl+K Ctrl+U` | Comment / uncomment (chord) |
| `Ctrl+D` | Add next cursor (multi-cursor) |
| `Ctrl+Up` / `Ctrl+Down` | Add cursor up / down |
| `Ctrl+Enter` / `Ctrl+Shift+Enter` | Insert line below / above |
| `Ctrl+Shift+K` | Delete line |
| `Ctrl+]` / `Ctrl+[` | Indent / outdent |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next / previous editor |
| `Ctrl+N` | New untitled buffer |
| `Ctrl+Shift+W` | Close editor |
| `Ctrl+Shift+T` | Reopen closed editor |
| `:e path/to/new/file.ts` + `:w` | Create file & dirs (auto `mkdir -p`) |
| `v` / `V` / `<C-v>` | Select char / line / block |
| `Shift+arrows` | Extend selection (VSCode-style) |
| `d` / `dd` / `x` | Delete selection / line / char |
| `Ctrl+X` | Cut (visual mode) |
| `Ctrl+Shift+K` | Delete line |
| `Ctrl+Shift+G` | Source control (Neogit) |
| `Opt+Cmd+B` | Git changes sidebar (CodeDiff) — VSCode-style diff |
| `Ctrl+Shift+M` | Show problems (Trouble) |
| `Ctrl+Shift+O` | File symbols |
| `Ctrl+T` | Workspace symbols |
| `Ctrl+Shift+R` | Recent files |
| `Ctrl+=` / `Ctrl+-` | Zoom in / out |
| `Alt+Up` / `Alt+Down` | Move line up / down |
| `Alt+Shift+F` | Format document |
| `Alt+F12` | Peek definition |
| `Alt+Z` | Toggle word wrap |
| `F2` | Rename symbol |
| `F12` | Go to definition |
| `Shift+F12` | Find references |
| `F8` / `Shift+F8` | Next / previous problem |
| `F5` / `F9` / `F10` / `F11` | Debug: continue / breakpoint / step over / step into |
| `Ctrl+. `, | Quick fix (code action) |
| `Ctrl+,` | Open settings |

> On macOS, `Ctrl` mirrors to `Cmd` automatically for these bindings.

## Leader Keybindings

| Key | Action |
|-----|--------|
| `<space>sh` | Search help |
| `<space>sk` | Search keymaps |
| `<space>sf` | Search files |
| `<space>sg` | Live grep |
| `<space>sw` | Search current word |
| `<space>sd` | Search diagnostics |
| `<space>sr` | Resume search |
| `<space>s.` | Recent files |
| `<space>sn` | Search neovim files |
| `<space><space>` | Find buffers |
| `<space>/` | Fuzzy search in buffer |
| `<space>sp` | Spectre toggle |
| `<space>sW` | Spectre word / selection |
| `<space>e` | Toggle file explorer |
| `<space>xx` | Toggle trouble (diagnostics) |
| `<space>gg` | Open git UI (neogit) |
| `<space>gc` / `<space>gp` / `<space>gl` | Git commit / push / pull |
| `<space>gd` | CodeDiff: changes sidebar (VSCode-style diff) |
| `<space>gD` | CodeDiff: git history |
| `<space>gf` | CodeDiff: current file vs HEAD |
| `<space>ga` | AI commit message (aicommits via OpenCode Go) |
| `<space>gb` | Toggle git blame |
| `<space>pp` | Project switcher |
| `<space>qs` / `<space>ql` / `<space>qd` | Restore / restore last / stop session |
| `<space>tt` | Theme picker |
| `<space>tv` / `<space>to` / `<space>tc` / `<space>tg` / `<space>tD` / `<space>tn` | VSCode / Tokyo Night / Catppuccin / Gruvbox / Dracula / Nord |
| `<space>tf` / `<space>tV` / `<space>th` | Floating / vertical / horizontal terminal |
| `<space>f` | Format buffer |
| `<space>o` | Toggle outline |
| `<space>du` | Toggle debug UI |
| `<space>ti` | Toggle inlay hints (LSP buffer) |
| `<space>hs` / `<space>hr` / `<space>hp` / `<space>hb` | Git hunk stage / reset / preview / blame |

## LSP Mappings

| Key | Action |
|-----|--------|
| `grd` / `F12` | Go to definition |
| `gD` | Go to definition in **vsplit** (read std source) |
| `gH` | Go to definition in **hsplit** |
| `grr` / `Shift+F12` | Find references |
| `gri` / `gI` | Go to implementation (in-place / vsplit) |
| `grn` / `F2` | Rename |
| `gra` / `Ctrl+.` | Code action |
| `K` | Hover documentation |
| `Ctrl+K` | Signature help |
| `gO` / `Ctrl+Shift+O` | Document symbols |
| `gW` / `Ctrl+T` | Workspace symbols |
| `<space>o` | Toggle outline panel |
| `<space>ti` | Toggle inlay hints |

## Theme Switching

| Key | Theme |
|-----|-------|
| `<space>tt` | Theme picker (Telescope) |
| `<space>tc` | Catppuccin (Mocha) — **default** |
| `<space>to` | Tokyo Night |
| `<space>tv` | VSCode |
| `<space>tg` | Gruvbox |
| `<space>tD` | Dracula |
| `<space>tn` | Nord |

## Installation

```sh
git clone https://github.com/tacheraSasi/0xVim.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

Requires: Neovim 0.10+, git, ripgrep, a Nerd Font, and language-specific tooling (go, rust, node, etc.) for LSP support.
