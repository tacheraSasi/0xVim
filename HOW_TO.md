# How To Neovim Config Guide

A practical, walk-through guide for this Neovim setup. Start at the top and follow
along in your editor. Every key combo below is something you can press right now.

> **Conventions in this doc**
>
> - `<C-x>` = hold `Ctrl` and press `x`
> - `<S-x>` = hold `Shift` and press `x`
> - `<D-x>` = hold `Cmd` (mac) and press `x`
> - `<Space>` = the leader key (spacebar)
> - `<CR>` = Enter / Return
> - `<Esc>` = Escape
> - On **macOS**, any `<C-...>` binding also works with `<D-...>` (Cmd) automatically.

---

## Table of Contents

1. [Prerequisites & Installation](#1-prerequisites--installation)
2. [First Run (what to expect)](#2-first-run--what-to-expected)
3. [The 60-Second Crash Course](#3-the-60-second-crash-course)
4. [Modes: The One Thing You Must Understand](#4-modes-the-one-thing-you-must-understand)
5. [Opening & Managing Files](#5-opening--managing-files)
6. [The Explorer (Right Sidebar)](#6-the-explorer-right-sidebar)
7. [Editing Like VS Code](#7-editing-like-vs-code)
8. [Multi-Cursor Editing](#8-multi-cursor-editing)
9. [Search & Replace](#9-search--replace)
10. [Code Intelligence (LSP)](#10-code-intelligence-lsp)
11. [Autocomplete (blink.cmp)](#11-autocomplete-blinkcmp)
12. [Fuzzy Finder (Telescope)](#12-fuzzy-finder-telescope)
13. [Splits & Windows](#13-splits--windows)
14. [Terminal Integration](#14-terminal-integration)
15. [Git Workflow](#15-git-workflow)
16. [Debugging (DAP)](#16-debugging-dap)
17. [Sessions & Projects](#17-sessions--projects)
18. [Themes](#18-themes)
19. [Plugin Manager (Lazy)](#19-plugin-manager-lazy)
20. [LSP & Formatter Installer (Mason)](#20-lsp--formatter-installer-mason)
21. [Vim Superpowers (beyond VSCode)](#21-vim-superpowers-beyond-vscode)
22. [Quality-of-Life: Snacks & Tailwind](#22-quality-of-life-snacks--tailwind)
23. [Language Tooling: Lint, Tests & Per-Language Extras](#23-language-tooling-lint-tests--per-language-extras)
24. [Customizing the Config](#24-customizing-the-config)
25. [Troubleshooting](#25-troubleshooting)
26. [Cheat Sheet (print this)](#26-cheat-sheet-print-this)

---

## 1. Prerequisites & Installation

### Required tools on your system

Install these first — the config depends on them.

| Tool | Why | Install (mac) |
|------|-----|---------------|
| **Neovim 0.11+** | Editor itself | `brew install neovim` |
| **ripgrep** | Fast search (telescope/spectre) | `brew install ripgrep` |
| **fd** (optional) | Faster file listing | `brew install fd` |
| **git** | Plugin manager + git features | `brew install git` |
| **a Nerd Font** | Icons in the UI | `brew install --cask font-jetbrains-mono-nerd-font` |
| **node** | TypeScript/JS LSP, formatters | `brew install node` |
| **Python 3 + pip** | Python LSP, formatters | `brew install python` |
| **Go** | Go LSP + tools | `brew install go` |
| **Rust** | rust-analyzer + rustfmt | `brew install rustup` |
| **Zig** (optional) | zls LSP + zig formatter | `brew install zig` |
| **PHP** (optional) | intelephense LSP + php-cs-fixer | `brew install php composer` |
| **make + clang** | Build native plugins | `brew install make clang` |

Set the Nerd Font in **your terminal app's preferences** (iTerm2, Alacitty,
Ghostty, etc.) — *not* in Neovim. Without it you'll see boxes instead of icons.

### Install this config

```sh
# Back up any existing config
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Clone this repo into place
git clone https://github.com/tacheraSasi/0xVim.git ~/.config/nvim

# First launch — plugins auto-install
nvim
```

On first launch, `lazy.nvim` will clone every plugin. You'll see a progress UI.
Wait for it to finish (usually 20–60 seconds), then restart Neovim once so
Mason can install language servers.

### Verify it works

```sh
nvim --headless "+lua print('OK')" +qa
```

Should print `OK` with no errors.

---

## 2. First Run (what to expect)

When you open `nvim` with no arguments you'll see the **dashboard**:

```
                                                 
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ...
                                                

  [f] Files        [r] Recent
  [c] Config       [l] Lazy
  [q] Quit

  Recent projects:
  > ~/code/myapp
  > ~/code/website
```

Press a letter to run that shortcut, or just press `<CR>` on a recent project
to restore its session.

**First-time setup checklist:**

1. Open Neovim, let plugins install.
2. Run `:Mason` — install the servers/formatters for the languages you use
   (they auto-install on first open of a file of that type, but you can pre-install).
3. Run `:checkhealth` — fix anything red.
4. Open a real project: `cd ~/code/myapp && nvim`.
5. Press `<Space>` and **hesitate** — `which-key` shows every group available.
   This is your safety net. You never need to memorize everything.

---

## 3. The 60-Second Crash Course

Open a project and try these in order. Don't worry about why yet — just feel it.

```sh
cd ~/code/some-project
nvim
```

1. **`Ctrl+P`** → type a few letters → `Enter` — open any file.
2. **`Ctrl+B`** — toggle the file explorer on the right. Press again to close.
3. **`i`** — enter insert mode. Type some junk. **`<Esc>`** — back to normal.
4. **`Ctrl+S`** — save (stays in insert mode). On macOS, **`Cmd+S`** also saves
   but leaves insert mode and returns to normal.
5. **`Ctrl+D`** on a word — press 3 times. You now have 4 cursors. Type
   something — it edits all of them. **`<Esc>`** exits.
6. **`<Space>`** — hesitate. Read the menu. Press `<Space>e`? Press `<Space>g`?
   Explore. which-key will guide you.
7. **`:qa<CR>`** — quit everything.

That's 80% of daily usage. The rest is below.

---

## 4. Modes: The One Thing You Must Understand

VSCode is always in "type mode" and uses the mouse for everything. Neovim uses
**modes** so your keyboard does both editing and navigation at maximum speed.

| Mode | What it's for | How to get in | How to get out |
|------|---------------|---------------|----------------|
| **Normal** | Move, copy, delete, command — home base | `<Esc>` (always) | — |
| **Insert** | Type text like a normal editor | `i` / `a` / `o` | `<Esc>` |
| **Visual** | Select text (char/line/block) | `v` / `V` / `<C-v>` | `<Esc>` |
| **Command** | Run `:` commands | `:` | `<Esc>` or `<CR>` |
| **Terminal** | Inside a terminal buffer | `:terminal` / `Ctrl+Shift+\`` | `<Esc><Esc>` |
| **Replace** | Overwrite text | `R` | `<Esc>` |

**Golden rule**: When in doubt, press `<Esc>`. You almost always want to be in
**Normal mode**. Insert mode is a place you visit, not where you live.

### Insert-mode entry keys (memorize these)

| Key | Where the cursor goes |
|-----|-----------------------|
| `i` | Insert **before** cursor |
| `a` | Insert **after** cursor |
| `I` | Insert at **start of line** |
| `A` | Insert at **end of line** |
| `o` | Open new line **below**, insert there |
| `O` | Open new line **above**, insert there |

This config maps `Ctrl+Enter` / `Ctrl+Shift+Enter` to the same as `o` / `O`
but without entering insert mode (pure line insertion, VSCode-style).

---

## 5. Opening & Managing Files

### Quick open (VSCode-style)

| Key | Action |
|-----|--------|
| `Ctrl+P` | Fuzzy-find any file in the project, open it |
| `Ctrl+Shift+R` | Recent files across all projects |
| `Ctrl+Tab` | Next buffer (cycle the tab bar) |
| `Ctrl+Shift+Tab` | Previous buffer |
| `Ctrl+Shift+W` | Close current buffer |
| `Ctrl+Shift+T` | Reopen the buffer you just closed |
| `Ctrl+N` | New empty file |
| `<Space><Space>` | Pick from currently-open buffers |

### From the command line

```sh
nvim file.go              # open one file
nvim .                    # open the directory (uses neo-tree)
nvim -p a.ts b.ts c.ts    # open in tabs
nvim -o a.ts b.ts         # open in horizontal splits
nvim -O a.ts b.ts         # open in vertical splits
nvim +"Telescope find_files"   # launch picker on startup
```

### Creating files & directories

Neovim doesn't need an explicit "new file" command — just open a path
that doesn't exist and save it.

| Key | Action |
|-----|--------|
| `:e path/to/new/file.ts` | Create a buffer for a new file at that path |
| `:w` | Save — **parent dirs are created automatically** (E212 fix) |
| `Ctrl+N` | New untitled buffer |
| `:w /full/path/to/file.ts` | Name & save an untitled buffer at a specific path |

**Using the explorer** (neo-tree, right sidebar):
- Focus it with `Ctrl+B` or `<Space>e`
- Press `a` and type `path/to/new/file.ts` (neo-tree creates intermediate folders)
- Press `A` to create a directory instead

### Saving

> **E212 "Can't open file for writing" — auto-fixed.**
> Stock Neovim refuses to save a file when its parent directory doesn't exist
> (e.g. `:e newdir/file.go` then `:w`). This config has a `BufWritePre`
> autocmd in `lua/core/autocmds.lua` that runs `mkdir -p` on the parent
> directory automatically before every write. So `:e a/b/c/file.lua` → `:w`
> just works — `a/b/c/` is created for you. You'll see a small notification
> when a directory was created.

---

## 6. The Explorer (Right Sidebar)

The file explorer (neo-tree) lives on the **right** side of the screen.

### Toggling

| Key | Action |
|-----|--------|
| `Ctrl+B` | **Seamless toggle** — open or close; when closing, returns focus to your last editor window |
| `<D-B>` | Same, on macOS Cmd |
| `<Space>e` | Toggle (alternative) |
| `Ctrl+Shift+E` | Focus the explorer without toggling |
| `Ctrl+0` | Focus sidebar |
| `Ctrl+1` | Focus editor (jump back) |

The "seamless" part: when you press `Ctrl+B` to close, Neovim remembers the
last real editor window you were in and puts you back there — no random split
jumps.

### Inside the explorer

When the explorer is focused, these keys act on the selected file/folder:

| Key | Action |
|-----|--------|
| `Enter` / `l` | Open file / expand folder |
| `h` | Collapse folder (or go up) |
| `a` | **Add** new file (type path, `/` for folder) |
| `A` | Add new directory |
| `d` | Delete (asks confirmation) |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy (neo-tree internal) |
| `m` | Move (neo-tree internal) |
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `P` | Preview (floating popup) |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `/` | Fuzzy filter |
| `<BS>` | Go up a directory |
| `.` | Set root here |
| `]g` / `[g` | Next / previous git-modified file |
| `q` | Close explorer |
| `?` | Help (shows all keys) |

**Tip**: Type `a path/to/new/file.ts` — neo-tree creates intermediate folders
automatically.

---

## 7. Editing Like VS Code

These work in **normal mode** unless noted. They mirror VSCode/Zed defaults.

### Cursor movement (Zed / VSCode-style)

These mappings give you the exact Option-arrow / Cmd-arrow behaviour you're
used to in Zed and VSCode — and crucially they work in **both normal and
insert mode**, so you can jump word-by-word *while typing*.

| Key | Mode | Action |
|-----|------|--------|
| `Opt+←` / `Alt+←` | n, v, i | **Back a word** (Zed: `b`) |
| `Opt+→` / `Alt+→` | n, v, i | **Forward a word** (Zed: `w`) |
| `Opt+↑` | n, v, i | Start of previous paragraph (`{`) |
| `Opt+↓` | n, v, i | End of next paragraph (`}`) |
| `Cmd+←` (GUI) | n, v, i | Start of line (`0`) |
| `Cmd+→` (GUI) | n, v, i | End of line (`$`) |
| `Cmd+↑` (GUI) | n, v, i | Top of file (`gg`) |
| `Cmd+↓` (GUI) | n, v, i | Bottom of file (`G`) |

**Word-wise deletion (Zed-style):**

| Key | Mode | Action |
|-----|------|--------|
| `Opt+Backspace` | insert | Delete word back (`Ctrl+W`) |
| `Opt+Delete` | insert | Delete word forward (`de`) |
| `Cmd+Backspace` (GUI) | insert | Delete to line start (`Ctrl+U`) |
| `Cmd+Delete` (GUI) | insert | Delete to line end (`d$`) |

**Word-wise selection (Shift+Opt+arrows):**

| Key | Mode | Action |
|-----|------|--------|
| `Shift+Opt+←` | visual | Extend back by word (`b`) |
| `Shift+Opt+→` | visual | Extend forward by word (`w`) |
| `Shift+Cmd+←` (GUI) | visual | Extend to line start (`0`) |
| `Shift+Cmd+→` (GUI) | visual | Extend to line end (`$`) |

> **Terminal compatibility note**
> Different macOS terminals send different bytes for Opt+arrow:
>
> - **Terminal.app** sends `Meta+arrow` — handled by the `<M-Left>` mapping.
> - **iTerm2 / Ghostty / Alacritty / kitty / WezTerm** send raw CSI sequences
>   like `\e[1;3D` — handled by the raw-escape mappings in
>   `lua/core/vscode-keybindings.lua`.
>
> If Opt+arrows don't work in your terminal:
>
> 1. Run `:checkhealth vim.ui` and verify key decoding.
> 2. In iTerm2: **Preferences → Profiles → Keys** and add Opt+arrow
>    actions that send "Escape sequence" `\e[1;3D` / `\e[1;3C` / `\e[1;3A` /
>    `\e[1;3B` — or just pick "Natural text editing" preset.
> 3. In Terminal.app: **Preferences → Profiles → Keyboard** → check
>    "Use Option as Meta key".
>
> `Cmd+arrow` mappings **only work in GUI Neovim** (Neovide, Neovim-qt) —
> terminal apps intercept Cmd before Neovim sees the key.

### Cut / Copy / Paste

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+X` | Visual | Cut selection |
| `Ctrl+C` | Visual | Copy selection |
| `Ctrl+V` | Normal / Insert / Command | Paste |
| `Ctrl+A` | Normal | Select whole file |

### Undo / Redo

| Key | Action |
|-----|--------|
| `Ctrl+Z` | Undo (works in insert mode) |
| `Ctrl+Y` | Redo (works in insert mode) |
| `u` | Undo (normal mode) |
| `Ctrl+R` | Redo (normal mode) |

### Line operations

| Key | Action |
|-----|--------|
| `Ctrl+Shift+K` | Delete current line |
| `Alt+Up` | Move current line up |
| `Alt+Down` | Move current line down |
| `Ctrl+Enter` | Insert blank line below |
| `Ctrl+Shift+Enter` | Insert blank line above |
| `Alt+Z` | Toggle word wrap |

> In visual mode, `Alt+Up` / `Alt+Down` move the whole selection.

### Indentation

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+]` | Normal | Indent current line |
| `Ctrl+[` | Normal | Outdent current line |
| `Ctrl+]` | Visual | Indent selection (keeps it selected) |
| `Ctrl+[` | Visual | Outdent selection (keeps it selected) |
| `>` / `<` (vim) | Visual | Same, native |

### Comments

| Key | Action |
|-----|--------|
| `Ctrl+/` | Toggle line comment (normal or visual) |
| `Ctrl+_` | Same — terminals often send this for `Ctrl+/` |
| `Ctrl+K Ctrl+C` | Comment (VSCode chord style) |
| `Ctrl+K Ctrl+U` | Uncomment (VSCode chord style) |
| `gcc` | Native toggle (normal) |
| `gc` (motion) | Native toggle (e.g. `gcap` = comment paragraph) |

### Formatting

| Key | Action |
|-----|--------|
| `Alt+Shift+F` | Format the whole document |
| `<Space>f` | Format (also works on visual selection) |

Formatting **also runs automatically on save** via `conform.nvim`, using
the right tool per filetype (prettier for JS/TS, stylua for Lua, gofumpt for
Go, black for Python, etc.). You can disable this per-filetype in
`lua/plugins/conform.lua` (the `disable_filetypes` table).

### Selecting & Deleting

#### VSCode-style select + delete

| Key | Action |
|-----|--------|
| `Shift+←/→/↑/↓` | Extend selection by char/line |
| `Shift+Opt+←/→` | Extend selection by word |
| `Shift+Cmd+←/→` | Extend selection to line start/end |
| `Ctrl+A` | Select all |
| `Ctrl+X` | Cut (visual mode) |
| `Ctrl+D` | Add next cursor, then delete/del to remove |

#### Vim-style selection (faster once learned)

| Key | What it selects |
|-----|-----------------|
| `v` | Start char-wise selection |
| `V` | Line-wise selection |
| `<C-v>` | Block selection (rectangular — great for column edits) |
| `viw` | Select inner word |
| `vi"` | Select inside quotes |
| `vi(` | Select inside parens |
| `vap` | Select around paragraph |
| `ggVG` | Select whole file (or `Ctrl+A`) |

After selecting in visual mode, press:
`d` or `x` — delete, `y` — copy (yank), `c` — change (delete + insert),
`>` — indent, `<` — outdent, `~` — toggle case.

#### Delete without selecting (normal mode)

| Key | Action |
|-----|--------|
| `dd` | Delete current line |
| `dw` | Delete to start of next word |
| `d$` / `D` | Delete to end of line |
| `d0` | Delete to start of line |
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dap` | Delete around paragraph |
| `diw` | Delete inner word |
| `Ctrl+Shift+K` | Delete line (VSCode-style) |

To delete without saving to the clipboard (black-hole register): `"_dd`,
`"_dw`, `"_d$`, etc.

---

## 8. Multi-Cursor Editing

Powered by `vim-visual-multi`, configured to match VSCode.

| Key | Action |
|-----|--------|
| `Ctrl+D` | **Add next occurrence** of word under cursor as a new cursor (keep pressing) |
| `<D-D>` | Same, on macOS Cmd |
| `Ctrl+Down` | Add a cursor on the line below |
| `Ctrl+Up` | Add a cursor on the line above |
| `Ctrl+Enter` | Add a cursor at current position (manual) |
| `n` / `N` | Skip current match / go back (during `Ctrl+D` session) |
| `q` | Remove current cursor |
| `Q` | Remove all cursors but the first |
| `<Esc>` | Exit multi-cursor mode |

### Try it

1. Put cursor on a variable name.
2. Press `Ctrl+D` three times — you have 4 cursors on 4 occurrences.
3. Press `c` and type a new name — all 4 rename at once.
4. `<Esc>`.

### Vertical column edit (block mode)

1. `Ctrl+V` (block select).
2. Move down with `j` to span the lines.
3. `I` (capital i) to insert at the start of each line.
4. Type `//` — comments appear on every line.
5. `<Esc>`.

---

## 9. Search & Replace

### In the current file

| Key | Action |
|-----|--------|
| `Ctrl+F` | Start search (type your pattern, `Enter`) |
| `n` | Next match |
| `N` | Previous match |
| `Ctrl+R` | Replace — opens `:s/` for current line |
| `:s/old/new/g<CR>` | Replace all in current line |
| `:%s/old/new/gc<CR>` | Replace all in file, ask each time (`y`/`n`) |
| `<Space>/` | Fuzzy find inside current buffer (Telescope) |

### Across the project

| Key | Action |
|-----|--------|
| `Ctrl+Shift+F` | Live grep (Telescope) — type to filter, `<CR>` to open |
| `Ctrl+Shift+H` | Replace across files (Spectre) |
| `<Space>sg` | Same as `Ctrl+Shift+F` |
| `<Space>sw` | Search the word under your cursor |
| `<Space>sp` | Toggle Spectre |
| `<Space>sW` | Spectre on word / selection |

### Using Spectre (project-wide replace)

1. Press `Ctrl+Shift+H` (or `<Space>sp`).
2. A panel opens with `search`, `replace`, `path` fields.
3. Tab between fields. Type your search and replacement.
4. Press `Enter` on a file in the list to preview.
5. Press `<Space>rc` to replace in the current file,
   `<Space>R` to replace across **all** files.

### Search navigation tips

- After `Ctrl+F` + `Enter`, press `n` to jump to the next match — the screen
  auto-centers (`nzzzv` is mapped for you).
- `:noh<CR>` or just `<Esc>` clears the highlight.

---

## 10. Code Intelligence (LSP)

The LSP installs servers automatically via Mason on first open of a file of
each language. Give it a few seconds the first time.

### Viewing documentation (the "hover" feature)

This is the equivalent of hovering your mouse over a function in Zed/VSCode.
Put your cursor on a function / type / variable and press one of:

| Key | What you get |
|-----|--------------|
| **`K`** | Full hover docs — docstring, signature, types. **The main one.** |
| `Ctrl+K` | Signature help (only the parameters) while typing inside `(...)` |
| `Alt+F12` | **Peek** the definition source in a popup (don't leave your spot) |
| `gd` / `F12` | Jump to the definition (use `Ctrl+O` to come back) |
| `gD` | Open definition in a **vsplit** — read the real std source alongside |
| `Shift+F12` / `grr` | Find every place that calls this |

**Inside the hover/peek popup:** scroll with `Ctrl+F` (down) / `Ctrl+B` (up),
close with `<Esc>` or `q`.

#### Per-language: what the hover shows

| Language | LSP server | Hover shows |
|----------|-----------|-------------|
| **Go** | `gopls` | godoc comment, signature, type info |
| **JS/TS** | `ts_ls` | TSDoc/JSDoc, params, return type |
| **Zig** | `zls` | doc comment (`///`), signature, type |
| **PHP/Laravel** | `intelephense` | PHPDoc, signature, type info |
| **Python** | `pyright` | docstring, types |
| **Rust** | `rust_analyzer` | rustdoc, signature, generics |
| **Lua** | `lua_ls` | vim docs, signature |
| **C/C++** | `clangd` | Doxygen comment, signature |
| **Vue** | `volar` | component props, types |
| **Svelte** | `svelte` | component props, types |
| **Prisma** | `prismals` | schema field types |
| **GraphQL** | `graphql` | type definitions |
| **HTML/CSS** | `html` / `cssls` | MDN-style reference |
| **Tailwind** | `tailwindls` | class completion + color previews |

### Navigation

| Key | Action |
|-----|--------|
| `F12` / `gd` | Go to definition (in-place) |
| **`gD`** | Open definition in **vertical split** — see std source alongside your code |
| **`gH`** | Open definition in **horizontal split** |
| **`gI`** | Open implementation in **vertical split** (falls back to references when the server doesn't support implementations) |
| `Alt+F12` | **Peek** definition in a popup (don't leave your spot) |
| `Shift+F12` / `gpr` | Find all references in a **popup** (peek outside the file) |
| `grr` | Find all references (Telescope list) |
| `gri` | Go to implementation (in-place; falls back to references when unsupported) |
| `grD` | Go to declaration |
| `grt` | Go to type definition |
| `Ctrl+O` | Jump **back** in your tag stack (after `gd`/`gD`) |
| `Ctrl+I` | Jump forward |

> **Reading the actual stdlib source**: put your cursor on `fmt.Println` (Go),
> `std.debug.print` (Zig), or any function, press **`gD`** — the real source
> file opens in a split on the right. Press `Ctrl+W C` to close the split
> when done, or `Ctrl+O` to jump back.

### Refactoring & info

| Key | Action |
|-----|--------|
| `F2` | Rename symbol everywhere in the project |
| `Ctrl+.` | Code actions / Quick fix menu |
| `K` | Hover documentation (normal mode, cursor on symbol) |
| `Ctrl+K` | Signature help (while typing a function call) |
| `<Space>ti` | Toggle inlay hints (types/params inline) |

> **Lightbulb**: a  icon appears in the gutter whenever a code action
> (quick fix) is available at your cursor — you don't have to guess when to
> press `Ctrl+.`. Powered by `nvim-lightbulb`.

> **Rainbow brackets**: matching bracket pairs are colorized
> (red/yellow/blue/orange/green/violet/cyan) for easy nesting visibility —
> VSCode's "Bracket Pair Colorization". Powered by `rainbow-delimiters.nvim`.

### Document & workspace symbols

| Key | Action |
|-----|--------|
| `Ctrl+Shift+O` | File symbols (outline picker) |
| `Ctrl+T` | Workspace symbols |
| `gO` | Document symbols (Telescope) |
| `gW` | Workspace symbols (Telescope) |
| `<Space>o` | Toggle the symbols outline panel (right side, `outline.nvim`) |

### Diagnostics (errors/warnings)

| Key | Action |
|-----|--------|
| `F8` | Next diagnostic |
| `Shift+F8` | Previous diagnostic |
| `<Space>xx` | Open **Trouble** panel — all project diagnostics in one list |
| `<Space>xd` | Trouble, current document only |
| `<Space>xq` | Trouble, quickfix list |
| `<Space>q` | Diagnostics in the location list |
| `<Space>sd` | Search diagnostics (Telescope) |

In Trouble, press `r` to refresh, `<CR>` to jump, `q` to close.

---

## 11. Autocomplete (blink.cmp)

Just start typing. The menu pops up automatically.

| Key | Action |
|-----|--------|
| `Tab` / `<CR>` | Accept the highlighted item |
| `Down` / `Up` | Move selection |
| `Ctrl+N` / `Ctrl+P` | Move selection (alt) |
| `Ctrl+Space` | Force the menu to show (or refresh) |
| `Ctrl+E` | Cancel / hide the menu |
| `Ctrl+F` | Scroll documentation down |
| `Ctrl+B` | Scroll documentation up |
| `Ctrl+Y` | Accept (alt) |

Sources in the menu, in priority order:

1. **LSP** (functions, types from your language server)
2. **snippets** (LuaSnip + friendly-snippets)
3. **path** (file paths as you type)
4. **lazydev** (Neovim API when editing your config)

### Snippets

- Type a snippet trigger (e.g. `for` in JS), `Tab` to accept, then `Tab`
  jumps you to the next placeholder.
- `<C-l>` / `<C-h>` jump forward / back through snippet tabstops.

---

## 12. Fuzzy Finder (Telescope)

Telescope is the Swiss-army knife. Anything fuzzy-searchable goes through it.

### The most important pickers

| Key | Picker |
|-----|--------|
| `Ctrl+P` | Files in project |
| `Ctrl+Shift+P` | Command palette (run any Neovim command) |
| `Ctrl+Shift+R` | Recent files |
| `<Space><Space>` | Open buffers |
| `<Space>sf` | Find files |
| `<Space>sg` | Live grep |
| `<Space>sw` | Grep word under cursor |
| `<Space>sd` | Diagnostics |
| `<Space>sh` | Help docs |
| `<Space>sk` | Keymaps (find any mapping) |
| `<Space>sr` | Resume last picker |
| `<Space>s.` | Old files |
| `<Space>sn` | Find files in your Neovim config |
| `<Space>pp` | Switch project |

### Inside a Telescope picker

| Key | Action |
|-----|--------|
| Type | Filter |
| `<CR>` | Open selected |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `<C-p>` / `<C-n>` | Previous / next item |
| `<Up>` / `<Down>` | Same |
| `<C-u>` | Preview scroll up |
| `<C-d>` | Preview scroll down |
| `<Esc>` | Close picker |
| `<C-q>` | Send all results to the quickfix list |
| `<Tab>` | Select an item (multi-select) |
| `<S-Tab>` | Unselect |

---

## 13. Splits & Windows

| Key | Action |
|-----|--------|
| `Ctrl+\` | Split editor right (VSCode-style) |
| `<Space>w\|` | Vertical split |
| `<Space>w-` | Horizontal split |
| `<Space>ww` | Cycle to next window |
| `Ctrl+H` | Focus left |
| `Ctrl+J` | Focus down |
| `Ctrl+K` | Focus up |
| `Ctrl+L` | Focus right |
| `<Space>wd` | Close window |
| `<Space>w=` | Equalize sizes |
| `<Space>w<` / `w>` | Shrink / grow width |
| `<Space>w+` / `w-` | Grow / shrink height |

These `Ctrl+H/J/K/L` mappings also work **inside the terminal** — so you can
hop out of a terminal split without leaving insert mode in the destination.

### Tabs vs buffers

This config uses **bufferline** (the tab bar at the top shows buffers, not
real tabs). Each "tab" is a buffer. Cycle them with `Ctrl+Tab`.

If you want real Vim tabs (separate window layouts), use `:tabnew` /
`:tabn` / `:tabp` or `Ctrl+Shift+N` for a new tab.

---

## 14. Terminal Integration

Powered by `toggleterm.nvim`. Default direction is **floating** (your pick).

| Key | Action |
|-----|--------|
| **`Cmd+J`** (macOS) | Toggle floating terminal — seamless open/close |
| `Ctrl+Shift+\`` | Toggle floating terminal (fallback) |
| `<Space>tf` | Floating terminal (explicit) |
| `<Space>tV` | Vertical terminal (sidebar) |
| `<Space>th` | Horizontal terminal (bottom pane, like VSCode) |
| `<Esc><Esc>` | Exit terminal insert mode |
| `Ctrl+H/J/K/L` | Navigate splits from inside the terminal |

### Inside the terminal

- You start in **insert mode** — type commands normally.
- Press `<Esc><Esc>` (twice) to drop to normal mode on the terminal buffer
  (so you can copy text with `v`/`y`, scroll with `Ctrl+U`/`Ctrl+D`).
- Press `i` to go back to insert mode.

### Multiple terminals

```vim
:ToggleTerm direction=horizontal
```

Each call opens a new terminal. Use `:TermSelect` to pick which one to show.

---

## 15. Git Workflow

### VSCode-style diff & changes sidebar (codediff)

`codediff.nvim` gives you the exact VSCode Source-Control experience: a
**sidebar listing every changed file**, and clicking one opens a
**side-by-side diff** with character-level highlighting from VSCode's own
diff algorithm.

| Key | Action |
|-----|--------|
| **`Opt+Cmd+B`** (macOS) | Open the **changes sidebar** — all modified/staged/conflicted files |
| `<Space>gd` | Same |
| `<Space>gD` | Git **history** (list of commits, expand to files, `<CR>` to diff) |
| `<Space>gf` | Diff **current file** against `HEAD` |

#### Inside the changes sidebar

| Key | Action |
|-----|--------|
| `<CR>` / `Enter` | Open the diff for the selected file (side-by-side) |
| `j` / `k` | Move up/down — **the diff previews automatically** under the cursor |
| `i` | Toggle flat list / tree view |
| `S` | Stage all files |
| `U` | Unstage all files |
| `X` | Discard changes (restore file) |
| `gu` / `gs` | Toggle the "Changes" / "Staged Changes" groups |
| `K` | Hover — diff preview popup |
| `R` | Refresh git status |
| `q` | Close |

Files show VSCode-style status letters (`M`/`A`/`D`) and **line counts**
(`+12 -4`) in the sidebar.

**AI-commit from here:** stage with `S` / `-`, then `<Space>ga` — the AI
commit flow (aicommits) runs without leaving the panel.

#### Inside a diff

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous hunk (change) |
| `]f` / `[f` | Next / previous file |
| `t` | Toggle **side-by-side** / **inline** layout |
| `gc` | Toggle compact mode (fold unchanged regions) |
| `do` / `dp` | Get / put change (like vimdiff) |
| `<Space>hs` / `<Space>hu` | Stage / unstage hunk under cursor |
| `<Space>hr` | Discard hunk under cursor |
| `-` | Stage / unstage the whole file |
| `g?` | Help — every keymap in this view |
| `q` | Close the diff tab |

#### VSCode-style git diff from the command line

```sh
git difftool codediff     # view uncommitted changes in the diff view
```

(configured via `git config --global diff.tool codediff`)

### AI commit messages (aicommits.nvim)

Stage your changes, then let AI write the conventional-commit message.

| Key | Action |
|-----|--------|
| `<Space>ga` | Generate commit message(s) from staged changes, pick one, commit |
| `C` (in Neogit status) | Same, right from the Neogit buffer |

**Works inside CodeDiff too** — open the changes sidebar (`Opt+Cmd+B`), stage
files/hunks with `-` / `S`, then press `<Space>ga` right in the explorer or
history panel to AI-commit.

- Uses the **OpenCode Go** endpoint (`https://opencode.ai/zen/go/v1`) — no extra
  API keys needed beyond your OpenCode key.
- Set the key once in your shell profile:
  `export OPENCODE_API_KEY=...` (never commit it to the repo).
- Generates a single commit message option (`generate = 1` — OpenCode Go
  only supports `n = 1`; see `lua/plugins/aicommits.lua`).
- Diagnose with `:AICommitHealth`.

### Quick view

| Key | Action |
|-----|--------|
| `Ctrl+Shift+G` | Open **Neogit** (full magit-style git UI) |
| `<Space>gg` | Same |
| `<Space>gc` | Neogit commit |
| `<Space>gp` | Neogit push |
| `<Space>gl` | Neogit pull |
| `<Space>gb` | Toggle git blame virtual text |

### In-buffer git signs (gitsigns.nvim)

The gutter shows `+` (added), `~` (changed), `_` (deleted).

| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<Space>hs` | Stage hunk under cursor |
| `<Space>hS` | Stage whole buffer |
| `<Space>hr` | Reset hunk |
| `<Space>hp` | Preview hunk (popup diff) |
| `<Space>hb` | Blame current line (popup) |
| `<Space>hd` | Diff against index |
| `<Space>hD` | Diff against last commit |
| `<Space>tb` | Toggle line blame inline |

In **visual mode**, `<Space>hs` / `<Space>hr` stage / reset the selected
lines only.

### Inside Neogit

- `tab` to expand/collapse a section
- `s` to stage, `S` to stage all
- `c c` to commit (opens editor for the message)
- `P` to push, `p` to pull
- `$` for the git command history
- `?` for help
- `q` to close

---

## 16. Debugging (DAP)

For Go (`delve`) and C/C++/Rust (`codelldb`) — Mason installs the adapters.

| Key | Action |
|-----|--------|
| `F5` | Start debugging / continue |
| `F9` | Toggle breakpoint on current line |
| `F10` | Step over |
| `F11` | Step into |
| `Shift+F11` | Step out |
| `Shift+F5` | Stop debugging |
| `<Space>du` | Toggle the debug UI (REPL, scopes, stacks, watches) |
| `<Space>db` | Toggle breakpoint (alt) |
| `<Space>dB` | Conditional breakpoint (with condition string) |

When debugging starts, the UI opens automatically. When it stops, it closes.

### Setting up a debugger

For Go:

1. `:MasonInstall delve` (auto on first `F5` in a `.go` file)
2. Open a Go file, press `F5`. Done.

For Rust:

1. `:MasonInstall codelldb`
2. Open `main.rs`, press `F5`. The config auto-detects `cargo`.

For other languages you'll need a `dap` config — see
[the DAP wiki](https://github.com/mfussenegger/nvim-dap/wiki) for examples.
Drop configs in `lua/plugins/extra.lua` inside the dap `config` function.

---

## 17. Sessions & Projects

### Projects (project.nvim)

Projects are auto-detected from `.git`, `package.json`, `Cargo.toml`,
`go.mod`, `Makefile`, `build.zig`. When you open a file inside one, your
`cwd` switches to that project root automatically.

| Key | Action |
|-----|--------|
| `<Space>pp` | Switch project (Telescope picker) |

### Sessions (persistence.nvim)

Your window layout, open buffers, and current dir are saved per-project.

| Key | Action |
|-----|--------|
| `<Space>qs` | Restore session for the current dir |
| `<Space>ql` | Restore the last session you had open |
| `<Space>qd` | Quit **without** saving the session |

Sessions auto-save on exit. To disable for a particular session, use
`<Space>qd` instead of just quitting.

---

## 18. Themes

Default is **Catppuccin Mocha**. Several more are installed.

| Key | Theme |
|-----|-------|
| `<Space>tt` | Live picker (preview as you arrow through) |
| `<Space>tc` | Catppuccin (Mocha) — **default** |
| `<Space>to` | Tokyo Night |
| `<Space>tv` | VSCode |
| `<Space>tg` | Gruvbox |
| `<Space>tD` | Dracula |
| `<Space>tn` | Nord |

To make a different theme the default, edit
`lua/plugins/colorscheme.lua` — move the `vim.cmd.colorscheme 'catppuccin'`
line to your preferred theme's config block.

---

## 19. Plugin Manager (Lazy)

Run `:Lazy` to open the UI.

| Key (in Lazy UI) | Action |
|------------------|--------|
| `I` | Install missing plugins |
| `U` | Update all plugins |
| `S` | Sync (install + clean + update) |
| `C` | Check for updates |
| `r` | Reload a plugin (after editing its config) |
| `x` | Remove a plugin (after deleting its spec) |
| `q` | Close |

Plugin specs live in `lua/plugins/*.lua` — each file returns one plugin or
a list. Add a new file, save, restart Neovim, run `:Lazy sync`.

---

## 20. LSP & Formatter Installer (Mason)

Run `:Mason` to open the UI.

| Key (in Mason UI) | Action |
|------------------|--------|
| `i` | Install the package under cursor |
| `X` | Uninstall |
| `U` | Update all |
| `C` | Check for updates |
| `q` | Close |

### What's pre-configured

LSP servers (auto-install on first file open):

| Server | Language(s) |
|--------|------------|
| `ts_ls` | TypeScript, JavaScript, React, React Native, NestJS |
| `gopls` | Go |
| `zls` | Zig |
| `rust_analyzer` | Rust |
| `intelephense` | PHP / Laravel |
| `volar` | Vue |
| `svelte` | Svelte |
| `prismals` | Prisma (NestJS / React Native backends) |
| `graphql` | GraphQL |
| `tailwindls` | Tailwind CSS |
| `pyright` | Python |
| `clangd` | C / C++ |
| `html` / `cssls` | HTML / CSS |
| `jsonls` / `yamlls` | JSON / YAML (with schemastore) |
| `dockerls` / `docker_compose_language_service` | Docker / Compose |
| `bashls` | Bash / Shell |
| `marksman` | Markdown |
| `lua_ls` | Lua (Neovim config) |
| `lemminx` | XML |

Formatters (auto-install via `mason-tool-installer`, run on save via conform.nvim):

| Language | Formatter(s) |
|----------|-------------|
| Lua | `stylua` |
| JS/TS/JSX/TSX | `prettierd` → `prettier` (fallback) |
| Go | `goimports` + `gofumpt` |
| Zig | `zig fmt` |
| Rust | `rustfmt` |
| PHP | `php-cs-fixer` |
| Blade | `blade-formatter` → `prettierd` |
| Python | `isort` + `black` |
| Vue / Svelte | `prettierd` |
| GraphQL | `prettierd` |
| HTML / CSS / SCSS / LESS | `prettierd` |
| JSON / YAML | `prettierd` |
| Markdown / MDX | `prettierd` |
| Shell | `shfmt` |

Linters (auto-install):
`eslint_d`, `flake8`, `ruff`, `shellcheck`, `luacheck`, `phpstan`, `phpcs`,
`golangci-lint`, `revive`, `staticcheck`, `markdownlint-cli2`, `jsonlint`,
`yamllint`.

Debuggers:
`delve` (Go), `codelldb` (C/C++/Rust).

### Add a new LSP

1. Open `lua/plugins/lsp.lua`.
2. Add an entry to the `servers` table, e.g.:

   ```lua
   solargraph = {},
   ```

3. Save, restart Neovim.
4. Open a Ruby file — Mason installs `solargraph` automatically.

### Add a new formatter

1. Open `lua/plugins/conform.lua`.
2. Add to `formatters_by_ft`:

   ```lua
   ruby = { 'rubocop' },
   ```

3. Add `rubocop` to `ensure_installed` in `lua/plugins/lsp.lua`.
4. Restart Neovim.

---

## 21. Vim Superpowers (beyond VSCode)

These are the features that have no direct equivalent in VSCode/Zed — once
you internalize them you'll never go back. None of them are plugins; they're
built into Neovim.

### The dot-repeat (`.`)

The most powerful key in Vim. `.` repeats the **last change** you made —
insertion, deletion, indent, anything. Combined with a motion it's a mini-macro.

```
cwfoo<Esc>   — change word to "foo"
j.           — move down, repeat the change on the next word
j.           — again
```

Any time you find yourself doing the same edit twice: do it once, then `j.` `j.` `j.`.

### The jump list (where you've been)

| Key | Action |
|-----|--------|
| `Ctrl+O` | Jump **back** in the jump list (after `gd`, `F12`, `G`, search, etc.) |
| `Ctrl+I` | Jump **forward** |
| `:ju<CR>` | See the whole jump list with line numbers |

Every "big move" (`gd`, `Ctrl+]`, `G`, `/foo<CR>`, `F12`) pushes your
current location onto the jump list. `Ctrl+O` is your "back button" —
memorize it.

### The change list (where you just edited)

| Key | Action |
|-----|--------|
| `` ` `` `` ` `` | Jump to the last edited position (backtick twice) |
| `g;` | Go to the **previous** change position |
| `g,` | Go to the **next** change position |
| `:changes<CR>` | See the change list |

After scrolling away from where you were typing, `` `` `` or `g;` snaps you back.

### Marks (named bookmarks in a file)

| Key | Action |
|-----|--------|
| `ma` | Set mark `a` at the cursor (lowercase = local to file) |
| `mA` | Set mark `A` (uppercase = global, works across files) |
| `` `a `` | Jump **to the exact line+column** of mark `a` |
| `'a` | Jump to the **first non-blank** on mark `a`'s line |
| `:marks<CR>` | List all marks |
| `:delm a<CR>` | Delete mark `a` |

Use lowercase `a-z` for in-file marks, uppercase `A-Z` for cross-file
bookmarks (e.g. `mA` on your main file, then `` `A `` from anywhere jumps back).

### Registers (multiple clipboards)

| Key | Action |
|-----|--------|
| `"ay` | Yank selection into register `a` |
| `"ap` | Paste from register `a` |
| `"+y` | Yank into the system clipboard |
| `"+p` | Paste from the system clipboard |
| `:reg<CR>` | See all registers and their contents |
| `"0p` | Paste the **last yank** (even if you deleted something after) |

There are also special registers:

- `"0` — last yank
- `"1`–`"9` — numbered delete history (a stack of recent deletes)
- `"%` — current filename
- `"/` — last search pattern
- `":` — last Ex command

So `"0p` is "paste what I just yanked, ignoring the delete I did in between".

### Macros (record and replay a sequence)

| Key | Action |
|-----|--------|
| `qa` | Start recording into register `a` |
| `...` | Do your edits (everything is recorded) |
| `q` | Stop recording |
| `@a` | Play back the macro once |
| `@@` | Play back the **last** macro again |
| `5@a` | Play back 5 times |
| `:%normal @a<CR>` | Run the macro on every line in the file |

Macros + the dot-repeat are the secret weapon. Example: turn a list of
`foo` into `'foo',`:

```
qa          — start recording into a
I'<Esc>A',<Esc>   — insert ' at start, ', at end
q           — stop
j@a         — replay on next line (or j@@ to keep going)
```

### Folds (collapse code blocks)

Treesitter folding is enabled by default (`foldmethod=expr`, treesitter
`foldexpr`). Folds start fully open (`foldlevelstart=99`).

| Key | Action |
|-----|--------|
| `zc` | Close fold under cursor |
| `zo` | Open fold under cursor |
| `za` | Toggle fold under cursor |
| `zC` / `zO` / `zA` | Close / open / toggle **recursively** (all nested) |
| `zr` | Reduce fold level by one (open one more level) |
| `zm` | Increase fold level by one (close one more level) |
| `zR` | Open **all** folds |
| `zM` | Close **all** folds |
| `zx` | Update folds and open the one under cursor |
| `zn` | Disable folding entirely |
| `[z` / `]z` | Jump to start / end of current fold |

Folds follow syntax structure (functions, classes, blocks) thanks to
treesitter — so `zc` on a function header collapses the whole body.

### Quickfix and location lists

| Key | Action |
|-----|--------|
| `:copen<CR>` | Open the quickfix list |
| `:cnext<CR>` / `:cprev<CR>` | Next / prev entry |
| `:cnf<CR>` / `:cpf<CR>` | Next / prev **file** in the list |
| `:cclose<CR>` | Close |
| `:lopen<CR>` / `:lclose<CR>` | Same for the location list (window-local) |
| `:lnext<CR>` / `:lprev<CR>` | Location list nav |
| `<Space>q` | Send current diagnostics to the location list |

Many tools populate the quickfix list: `:vimgrep`, `:make`, Grep searches,
`Ctrl+Q` from a Telescope picker, Spectre, etc. Treat it as a "results tab"
you can walk through with `:cn` / `:cp`.

### Spell check

| Key | Action |
|-----|--------|
| `:set spell<CR>` | Enable spell check for current buffer |
| `:set nospell<CR>` | Disable |
| `]s` / `[s` | Next / previous misspelled word |
| `z=` | Show spelling suggestions for word under cursor |
| `zg` | Add word to your dictionary ("good word") |
| `zw` | Mark word as bad |
| `zug` | Undo the last `zg` |

Set a default language with `:set spelllang=en_us` in `lua/core/options.lua`.

### Repeat ex commands with `@:`

After running any `:` command, press `@:` to run it again. `@@` repeats it
further. Great for `:cnext` after a search — `:cn<CR>` then `@@` `@@` `@@`.

### Window resize with the mouse / keyboard

| Key | Action |
|-----|--------|
| `<Space>w<` / `<Space>w>` | Shrink / grow width |
| `<Space>w+` / `<Space>w-` | Grow / shrink height |
| `<Space>w=` | Equalize all splits |
| Drag the divider with the mouse | Also works (mouse is enabled) |

### Numbers and relative jumps

With `relativenumber` on (it is), the gutter shows distances from your
cursor. Type the number + a motion to jump: `12j` (down 12), `7k` (up 7),
`5w` (forward 5 words). You'll see the number to land on right next to the line.

---

## 22. Quality-of-Life: Snacks & Tailwind

### Snacks.nvim (smooth scrolling, zen mode, lazygit, images)

`folke/snacks.nvim` bundles several small quality-of-life features:

- **Smooth scrolling** — `Ctrl+U` / `Ctrl+D`, `gg` / `G`, fold toggles and more animate
  smoothly instead of jumping.
- **Zen mode** (`<Space>uz`) — hides everything except your code. Press again to exit.
- **Lazygit** (`<Space>lg`) — the popular TUI git client in a floating window.
  Requires the `lazygit` binary (installed via Homebrew).
- **Image previews** — PNG / JPG / GIF / WEBP / PDF etc. render inline in the buffer
  (works in Ghostty, kitty and WezTerm).
- **Indent guides** — replaced indent-blankline; same `│` guides with scope
  highlighting.
- **Big file mode** — buffers larger than 1.5 MB automatically disable treesitter
  and folding so they stay snappy.
- **Word references** — `]]` / `[[` jump between LSP references of the word under
  the cursor, like VSCode's reference navigation.
- **Quickfile** — files opened from the command line render instantly, before
  plugins finish loading.

### Tailwind CSS tools (tailwind-tools.nvim)

VSCode-style Tailwind intellisense for Neovim:

- **Color hints** — inline color swatches next to Tailwind color classes
  (`TailwindColorToggle` to toggle).
- **Class motions** — `TailwindNextClass` / `TailwindPrevClass` jump between class
  attributes in the buffer.
- **Smart increment** — `<C-a>` / `<C-x>` cycle Tailwind unit values (`p-2` → `p-4`).
- **Class sorting** — `TailwindSort` / `TailwindSortSelection` sort classes without
  needing the prettier Tailwind plugin.
- **Class previewer** — `:Telescope tailwind classes` (jump to classes in the file)
  and `:Telescope tailwind utilities` (browse all utility classes in the project).
- **Conceal** — `TailwindConcealToggle` hides long class lists behind a single icon.

Requires `tailwindcss-language-server` (installed via Mason) plus the `html`, `css`
and `tsx` treesitter parsers — all pre-configured.

### Animated cursor (smear-cursor.nvim)

The cursor leaves a smooth animated trail when moving — the Neovide effect in
any terminal. Enabled by default (normal + insert mode, buffer switches, and
scrolling included).

- Toggle with `:SmearCursorToggle`
- Tune speed/stiffness in `lua/plugins/smear-cursor.lua` (`stiffness`,
  `trailing_stiffness`, `distance_stop_animating`, …)

### Search marks on the scrollbar (hlslens)

Search matches (`/`, `?`, `*`, `#`) now show as `≡` marks on the scrollbar, and
hlslens displays a VSCode-style **match counter** (e.g. `3/14`) next to the
search line. `n` / `N` jump between them as usual.

## 23. Language Tooling: Lint, Tests & Per-Language Extras

### Linting (nvim-lint)

Linters run automatically when you open, save, or leave insert mode:

| Filetype | Linters |
|----------|---------|
| php | phpstan, phpcs |
| javascript / typescript / vue | eslint_d |
| go | golangci-lint |
| python | ruff, flake8 |
| sh / bash / zsh | shellcheck |
| lua | luacheck |
| yaml | yamllint |
| markdown | markdownlint-cli2 |

> PHPStan needs a `phpstan.neon` (or default level) in the project; ESLint needs
> its usual `eslint.config.js` / `.eslintrc`. No config, no output — by design.

### Testing (neotest)

Works for PHPUnit (Laravel), Jest (TS/JS) and Go tests:

| Key | Action |
|-----|--------|
| `<Space>nt` | Run nearest test (under cursor) |
| `<Space>nT` | Run current test file |
| `<Space>nR` | Run all tests in the project |
| `<Space>ns` | Toggle test summary panel |
| `<Space>no` | Show test output (enter to jump back) |

Inside the summary panel use `j`/`k` to move and `o` to expand test results.

### PHP / Laravel (laravel.nvim)

Loads automatically in `php`/`blade` files. Keymap cheatsheet:

| Key | Action |
|-----|--------|
| `<Space>ll` | Master picker (everything searchable) |
| `<Space>la` | Artisan command picker |
| `<Space>lr` | Routes list (jump to controller method) |
| `<Space>lm` | `make:*` picker (models, controllers, migrations…) |
| `<Space>lo` | Resources (Controllers / Models / Migrations / …) |
| `<Space>lt` | Laravel code actions: `$fillable` generation, add relations, go-to-migration |
| `<Space>lu` | Artisan Hub (serve / vite / pail / logs tabs) |
| `<Space>lp` | Command Center (REPL with autocomplete) |
| `gf` | Laravel-aware: `route('…')`, `view('…')`, `config('…')`, `env('…')`, `Inertia::render('…')` |

Also included: virtual info above models (table/columns) and controller
methods (route/method/middleware), blink.cmp completion for `route()` /
`view()` / `config()` / `env()` / Eloquent columns, and `.tinker` files
(side-by-side live PHP REPL). Environment: run `Laravel.commands.run("env:configure")`
once per project if you use Sail/Docker instead of local php.

### TypeScript / JavaScript (typescript-tools.nvim)

Inlay hints (types, param names, enums), organize-imports code action on save,
better rename/import handling — all via the tsserver setup.

### Rust (rustaceanvim + crates.nvim)

| Command | Action |
|---------|--------|
| `:RustLsp runnables` | Run/debug binaries and tests via DAP |
| `:RustLsp debuggables` | Debug targets |
| `:RustLsp expandMacro` | Expand macro under cursor |
| `K` on hover | Extra hover actions (docs, open cargo.toml, source) |

`crates.nvim` — in `Cargo.toml`: `K` on a dependency shows versions,
`g?`-style keymaps let you bump/update versions inline.

### Go (gopher.nvim)

| Command | Action |
|---------|--------|
| `:GoTagAdd json` | Add struct tags (`:GoTagRm`, `:GoTagClear`) |
| `:GoIfErr` | Generate `if err != nil` boilerplate |
| `:GoFillStruct` / `:GoImpl` | Fill struct literal / implement interface |
| `:GoJson` | Generate struct from JSON |
| `:GoTestAdd` | Generate test scaffold for the function under cursor |

### C / C++ / Zig

- **clang-format** formats on save; clangd inlay hints enabled (types + param names).
- **Zig**: zls inlay hints enabled; `zig fmt` runs on save.

### Debugging (DAP) — new adapters

| Language | Adapter | Notes |
|----------|---------|-------|
| TS / JS | js-debug-adapter (`pwa-node`) | Breakpoints in plain node apps |
| PHP / Laravel | php-debug-adapter | Requires Xdebug listening on port 9003 |
| Go | delve | pre-existing |
| C / C++ / Rust / Zig | codelldb | pre-existing |

Same keys as always: `F5` continue, `F9` breakpoint, `F10`/`F11` step, `<Space>du` UI.

> **Mason PATH fix**: Mason-installed binaries (formatters, linters, debuggers)
> are now on Neovim's `PATH` automatically — previously formatters like
> prettierd/stylua were silently not running.

## 24. Customizing the Config

### Where things live

| File | What it does |
|------|--------------|
| `init.lua` | Bootstraps lazy.nvim, loads core modules |
| `lua/core/options.lua` | Vim options (tabs, UI, folding) |
| `lua/core/keymaps.lua` | Core keymaps + loads vscode-keybindings |
| `lua/core/vscode-keybindings.lua` | All the VSCode-style mappings |
| `lua/core/autocmds.lua` | Autocmds (yank highlight, organize imports, explorer focus tracking) |
| `lua/plugins/*.lua` | One file per plugin |
| `lua/plugins/init.lua` | Imports every plugin file |

### Add a keymap

In `lua/core/keymaps.lua`:

```lua
vim.keymap.set('n', '<leader>z', function()
  print('hello')
end, { desc = 'Say hello' })
```

The `desc` is what shows in which-key.

### Add a new plugin

Create `lua/plugins/my-plugin.lua`:

```lua
return {
  'author/plugin-name.nvim',
  opts = {},
}
```

Add to `lua/plugins/init.lua`:

```lua
{ import = 'plugins.my-plugin' },
```

Restart, run `:Lazy sync`.

### Change options

Edit `lua/core/options.lua`. To try one live without restarting:

```vim
:lua vim.o.relativenumber = false
```

### Change a theme color

After loading a theme, override a highlight group. Add to
`lua/core/autocmds.lua`:

```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup,
  callback = function()
    vim.api.nvim_set_hl(0, 'Comment', { italic = true, fg = '#7aa2f7' })
  end,
})
```

### Format on save — disable for a filetype

In `lua/plugins/conform.lua`, add to the `disable_filetypes` table:

```lua
local disable_filetypes = { c = true, cpp = true, rust = true }
```

---

## 25. Troubleshooting

### "I see boxes/tofu instead of icons"

Your terminal isn't using a Nerd Font. Install one:

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

Then set it in your terminal's preferences. Restart the terminal.

### "Colors look wrong / no syntax highlighting"

- Run `:checkhealth nvim-treesitter` — install missing parsers with `:TSUpdate`.
- Confirm `:set termguicolors` is on (it is by default).
- Some terminals need `set termguicolors` + a true-color `TERM` like
  `xterm-256color`. Try `export TERM=xterm-256color`.

### "LSP isn't starting"

1. `:Mason` — is the server installed? If not, install it.
2. `:LspInfo` — what servers are attached to the current buffer?
3. `:checkhealth` — read the LSP section.
4. Open `:LspLog` for server output.

### "Format on save isn't working"

- `:ConformInfo` — shows which formatter is selected and why.
- The tool must be installed (`:Mason`) and on your `$PATH`.
- Some filetypes are disabled by default (c, cpp).

### "A keymap doesn't do what I expect"

- `:verbose map <key>` — shows what it's mapped to and where it was set.
- `<Space>sk` — search all keymaps via Telescope.
- Conflicts: the **last-loaded** plugin wins. Check `:nmap <key>`.

### "Telescope is slow"

- Make sure `ripgrep` is installed (`brew install ripgrep`).
- `find_files` uses `rg --files` with ignore patterns; if your project is
  huge, the ignore list in `lua/plugins/telescope.lua` is your friend.
- For `live_grep`, add `--type` filters, e.g. search `foo -t ts`.

### "Autocomplete is too aggressive / not aggressive enough"

Edit `lua/plugins/blink.lua`:

- `trigger.show_on_keyword = true` — show menu on every word keystroke.
- `completion.documentation.auto_show_delay_ms = 200` — raise to be less eager.
- `keymap.preset = 'super-tab'` — Tab to accept (current). Try `'enter'` or
  `'none'` for other styles.

### "Neovim is using the wrong working directory"

- `<Space>pp` to switch project (auto-sets `cwd`).
- `:cd ~/path` to change manually.
- `:pwd` to check.

### "Option+arrow doesn't move word-by-word"

The config maps both `<M-Left>/<M-Right>` **and** the raw CSI sequences
(`\e[1;3D` etc.) that iTerm2/Ghostty/Alacritty/kitty/WezTerm send — so it
should work out of the box. If it doesn't:

1. **iTerm2**: Preferences → Profiles → Keys → Presets → "Natural text
   editing". Or manually add Opt+arrow keys sending escape sequences
   `\e[1;3D` / `\e[1;3C` / `\e[1;3A` / `\e[1;3B`.
2. **Terminal.app**: Preferences → Profiles → Keyboard → check
   "Use Option as Meta key".
3. **Alacritty / kitty / WezTerm**: usually work by default; if not, ensure
   `option_as_alt` / `macos_option_as_alt` is enabled in their config.
4. Verify with `:verbose map <M-Left>` — you should see `b` mapped.
5. Run `:map <Esc>[1;3D` — if you see `b`, the raw-escape mapping is live.

`Cmd+arrow` mappings **only fire in GUI Neovim** (Neovide) — terminal apps
capture Cmd themselves before Neovim sees the key. Use `gg` / `G` / `0` /
`$` instead, or the `Opt+arrow` word motions.

### "E212: Can't open file for writing"

This is **auto-fixed** by a `BufWritePre` autocmd that runs `mkdir -p` on
the file's parent directory before saving. If you somehow still hit it:

- Check `:verbose autocmd BufWritePre` — you should see the
  `Create parent dirs on write` entry from `lua/core/autocmds.lua`.
- Make sure you're not on a read-only filesystem or out of disk space
  (`df -h`).
- Check permissions on the target path: `ls -la /path/to/parent`.

### "Multi-cursor (`Ctrl+D`) doesn't work"

- `vim-visual-multi` should be installed (`:Lazy`).
- You must be in **normal mode** on a word, or in **visual mode** with a selection.
- `<Esc>` exits — press `Ctrl+D` again to start over.

### "How do I reset everything?"

```sh
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
git -C ~/.config/nvim checkout .
nvim  # reinstalls everything fresh
```

### "The dashboard is gone"

The dashboard only shows when you run `nvim` with no arguments. Open a file
directly with `nvim file.go` or `Ctrl+P` to skip it. To force it: `nvim +Dashboard`.

---

## 26. Cheat Sheet (print this)

```
┌─────────────────────────────────────────────────────────────────┐
│  FILES                     SEARCH                               │
│  Ctrl+P     quick open     Ctrl+F       find in file             │
│  Ctrl+B     toggle tree    Ctrl+R       replace in file          │
│  Ctrl+Tab   next buffer    Ctrl+Shift+F find in files            │
│  Ctrl+S     save           Ctrl+Shift+H replace in files         │
│  Ctrl+Shift+T reopen       Alt+Shift+F  format document          │
│  Ctrl+N     new file       <Space>/     fuzzy in buffer          │
│                                                                  │
│  CURSOR (Zed-style)         EDIT                                 │
│  Opt+<  word back          Ctrl+Z/Y    undo/redo                 │
│  Opt+>  word fwd           Ctrl+D      add next cursor           │
│  Opt+Up/Dn  paragraph      Ctrl+/      toggle comment            │
│  Cmd+<  line start (GUI)   Ctrl+K C/C  comment chord             │
│  Cmd+>  line end   (GUI)   Alt+Up/Dn   move line up/down        │
│  Cmd+Up/Dn top/bot (GUI)   Ctrl+Shift+K del line                │
│  Opt+BkSp del word back    Ctrl+Enter  new line below            │
│  Opt+Del  del word fwd     Ctrl+] / [  indent / outdent          │
│                                                                  │
│  CODE                       GO TO                                │
│  K        hover docs        F12 / gd   definition                │
│  Ctrl+K   signature         gD          definition in vsplit     │
│  F2       rename symbol     gH          definition in hsplit     │
│  Ctrl+.   quick fix         Alt+F12     peek definition           │
│   bulb    gutter = fix ready Shift+F12  find references           │
│  <Space>ti inlay hints      Ctrl+O      jump back                 │
│  F8 / S-F8 prev/next diag   Ctrl+Shift+O file symbols            │
│  ()  rainbow brackets       Ctrl+T      workspace symbols         │
│                                                                  │
│  WINDOWS                    GIT                                  │
│  Ctrl+\   split right       Opt+Cmd+B  changes sidebar (CodeDiff) │
│  Ctrl+H/J/K/L move focus    <Space>gd   CodeDiff sidebar          │
│  <Space>wd close win        <Space>gD   CodeDiff history          │
│  <Space>w= equalize         <Space>gf   diff file vs HEAD         │
│                             <Space>ga   AI commit message         │
│                             <Space>hs   stage hunk               │
│                             ]c / [c     next/prev change         │
│  TERMINAL                   Ctrl+Shift+G Neogit                  │
│  Cmd+J    toggle (macOS)    <Space>gb   toggle blame             │
│  Ctrl+Shift+` toggle                                              │
│  <Space>th bottom pane                                            │
│  <Space>tV vertical split                                         │
│                                                                  │
│  DEBUG                                                           │
│  F5  start/continue          F10 step over                       │
│  F9  toggle breakpoint       F11 step into                       │
│  S-F11 step out              S-F5 stop                           │
│                                                                  │
│  VIM SUPERPOWERS            PROJECT                              │
│  .        repeat last change <Space>pp switch project            │
│  Ctrl+O / Ctrl+I  jumplist  <Space>qs  restore session           │
│  g; / g,  change list       <Space>qd  quit, no session save     │
│  ma / `a  set / goto mark                                       │
│  qa...q / @a  record macro   HELP                                │
│  zc / zo / zR / zM  folds    :Lazy   plugin manager              │
│  "ay / "ap  register a       :Mason  LSP/formatter               │
│  :reg     show registers     :checkhealth                        │
│                              <Space>tt theme picker              │
│  PROJECT / HELP              <Space>   hesitate = which-key      │
└─────────────────────────────────────────────────────────────────┘
```

---

## What to do right now

1. Open a real project: `cd ~/code/something && nvim`
2. Press `Ctrl+P`, open a file you know.
3. Press `Ctrl+B`, browse with `h`/`l`, press `Ctrl+B` again — you're back.
4. Put your cursor on a function name, press `F12`, then `Ctrl+O`.
5. Press `<Space>` and hesitate. Read the menu. Try things.
6. Open `:Tutor` for a 30-minute Vim fundamentals lesson.

Welcome to Neovim.
