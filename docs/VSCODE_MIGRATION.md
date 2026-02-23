# VSCode to 0xVim Migration Guide

Welcome VSCode users! This guide will help you transition smoothly to 0xVim while maintaining the productivity you're used to.

## Overview

0xVim is designed to provide a VSCode-like experience in Neovim, with familiar keybindings and workflows. Most of your muscle memory will transfer directly!

## Quick Start for VSCode Users

### The Basics

| What You're Used To | In 0xVim | Notes |
|---------------------|----------|-------|
| `Ctrl+Shift+P` - Command Palette | `Ctrl+Shift+P` | Same! Opens command palette |
| `Ctrl+P` - Quick Open | `Ctrl+P` | Same! Quick file finder |
| `Ctrl+B` - Toggle Sidebar | `Ctrl+B` or `Ctrl+Shift+E` | Both work! |
| Ctrl+\` - Toggle Terminal | Ctrl+\` | Same! Floating terminal |
| `Ctrl+S` - Save | `Ctrl+S` | Same! |
| `Ctrl+F` - Find | `Ctrl+F` | Same! |
| `Ctrl+Shift+F` - Find in Files | `Ctrl+Shift+F` | Same! |

### Important Difference: The Leader Key

In 0xVim, `Space` is your **leader key** - think of it as a gateway to more commands. Many advanced features start with `Space`.

**Example:**
- Press `Space`, then wait a moment → a menu appears showing available commands
- Press `Space` then `f` → Format code
- Press `Space` then `?` → Open help guide

## Essential VSCode Features in 0xVim

### 1. File Explorer (Sidebar)

**VSCode:**
- `Ctrl+Shift+E` to show Explorer
- `Ctrl+B` to toggle sidebar

**0xVim:**
- `Ctrl+B` or `Ctrl+Shift+E` - Toggle Neo-tree sidebar
- Inside the sidebar:
  - `Enter` - Open file
  - `Space` - Expand/collapse folder
  - `a` - New file
  - `A` - New folder
  - `d` - Delete
  - `r` - Rename
  - `?` - Show all commands

### 2. Quick Open / File Search

**VSCode:** `Ctrl+P`

**0xVim:** `Ctrl+P` (exactly the same!)
- Type to filter files
- Enhanced: automatically filters out `node_modules/`, `dist/`, `.git/`, etc.
- Press `Enter` to open
- Use `Ctrl+N/P` or arrow keys to navigate

### 3. Command Palette

**VSCode:** `Ctrl+Shift+P`

**0xVim:** `Ctrl+Shift+P` (exactly the same!)
- Access all available commands
- Type to search
- Press `Enter` to execute

### 4. Find and Replace

**In File:**
| VSCode | 0xVim |
|--------|-------|
| `Ctrl+F` - Find | `Ctrl+F` - Find |
| `Ctrl+H` - Replace | `Ctrl+R` - Replace |
| `Enter` - Next match | `n` - Next, `N` - Previous |
| `Esc` - Close find | `Esc` - Close find |

**In Project:**
| VSCode | 0xVim |
|--------|-------|
| `Ctrl+Shift+F` - Find in Files | `Ctrl+Shift+F` - Find in Files |
| `Ctrl+Shift+H` - Replace in Files | `Ctrl+Shift+H` - Replace in Files (Spectre) |

### 5. Multi-Cursor Editing

**VSCode:** `Ctrl+D` to select next occurrence

**0xVim:** `Ctrl+D` (same!)
- Select a word, press `Ctrl+D` repeatedly to select next occurrences
- Edit all simultaneously

### 6. Line Operations

| Operation | VSCode | 0xVim |
|-----------|--------|-------|
| Delete line | `Ctrl+Shift+K` | `Ctrl+Shift+K` |
| Move line up | `Alt+Up` | `Alt+Up` |
| Move line down | `Alt+Down` | `Alt+Down` |
| Duplicate line | `Shift+Alt+Down` | `yyp` (Vim way) |
| Insert line below | `Ctrl+Enter` | `Ctrl+Enter` |
| Insert line above | `Ctrl+Shift+Enter` | `Ctrl+Shift+Enter` |

### 7. Code Editing

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| Comment line | `Ctrl+/` | `Ctrl+/` |
| Comment block | `Ctrl+Shift+/` | `Ctrl+Shift+/` |
| Format document | `Alt+Shift+F` | `Alt+Shift+F` or `<leader>f` |
| Quick fix | `Ctrl+.` | `Ctrl+.` |
| Go to definition | `F12` | `F12` or `gd` |
| Find references | `Shift+F12` | `Shift+F12` or `gr` |
| Rename symbol | `F2` | `F2` or `grn` |
| Peek definition | `Alt+F12` | `Alt+F12` |

### 8. Code Navigation

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| Go to line | `Ctrl+G` | `Ctrl+G` |
| Go to symbol | `Ctrl+Shift+O` | `Ctrl+T` or `gO` |
| Go to file | `Ctrl+P` | `Ctrl+P` |
| Navigate back | `Ctrl+-` | `Ctrl+O` (Vim) |
| Navigate forward | `Ctrl+Shift+-` | `Ctrl+I` (Vim) |

### 9. Split Editors

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| Split right | `Ctrl+\\` | `Ctrl+\\` |
| Split down | `Ctrl+K Ctrl+\\` | `Ctrl+K Ctrl+\\` |
| Navigate splits | `Ctrl+1/2/3` | `Ctrl+H/J/K/L` |
| Close split | `Ctrl+W` | `Ctrl+W` |

### 10. Terminal

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| Toggle terminal | Ctrl+\` | Ctrl+\` |
| New terminal | Ctrl+Shift+\` | Ctrl+Shift+\` |
| Exit terminal mode | N/A | `Esc` then navigate normally |

### 11. Git Integration

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| View changes | Git panel | `<leader>gg` - Neogit interface |
| Stage hunk | Click + in gutter | `<leader>hs` |
| Preview changes | Hover | `<leader>hp` |
| Next change | Go to next | `]c` |
| Previous change | Go to previous | `[c` |
| Git blame | Extensions | `<leader>gb` |

### 12. IntelliSense / Auto-completion

**VSCode:**
- Auto-appears as you type
- `Tab` or `Enter` to accept
- `Esc` to dismiss

**0xVim:**
- Same! Auto-appears as you type
- `Tab` to accept
- `Ctrl+Space` to manually trigger
- `Ctrl+E` to dismiss
- Navigate with `Ctrl+N` / `Ctrl+P` or arrow keys

### 13. Problems / Diagnostics

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| Next error | `F8` | `F8` or `]d` |
| Previous error | `Shift+F8` | `Shift+F8` or `[d` |
| Show problems | `Ctrl+Shift+M` | `Ctrl+Shift+M` or `<leader>xx` |
| Quick fix | `Ctrl+.` | `Ctrl+.` or `<leader>ca` |

## Common Workflows

### Opening a Project

**VSCode:**
```
File → Open Folder
```

**0xVim:**
```bash
# In terminal
cd /path/to/project
nvim .
```

Or use the project switcher: `<leader>pp`

### Searching for Text Across Files

**VSCode:**
1. `Ctrl+Shift+F`
2. Type search term
3. Browse results

**0xVim:**
1. `Ctrl+Shift+F`
2. Type search term
3. Browse with arrow keys, `Enter` to open
4. Or use `<leader>sg` (search grep)

### Refactoring Code

**VSCode:**
1. Select code
2. `Ctrl+.` for quick actions
3. Choose refactor

**0xVim:**
1. Select code (visual mode)
2. `<leader>ca` for code actions
3. Choose refactor
4. Or use specific commands:
   - `grn` - Rename
   - `gra` - Code actions
   - `<leader>f` - Format

### Installing Extensions/Plugins

**VSCode:**
1. `Ctrl+Shift+X` → Extensions
2. Search and install

**0xVim:**
1. Edit `~/.config/nvim/init.lua` or files in `lua/custom/plugins/`
2. Add plugin configuration
3. Restart Neovim → plugins auto-install
4. Or use `:Lazy` to manage plugins

### Changing Settings

**VSCode:**
1. `Ctrl+,` → Settings
2. Search and modify

**0xVim:**
1. Edit `~/.config/nvim/init.lua`
2. Modify Lua configuration
3. Restart or `:source %` to reload

## Themes and Appearance

### Changing Theme

**VSCode:** `Ctrl+K Ctrl+T`

**0xVim:**
- `<leader>tt` - Theme picker with live preview
- Specific themes:
  - `<leader>tv` - VSCode theme
  - `<leader>to` - Tokyo Night
  - `<leader>tc` - Catppuccin
  - See [THEMES.md](THEMES.md) for full list

## Keyboard Shortcuts Reference

### If You Forget a Shortcut

**The #1 Feature for VSCode Migrants:**

Press `<leader>?` or `F1` to open the **comprehensive How-To modal** with ALL commands organized by category!

**Alternative:**
Press `Space` and wait → Which-Key will show available commands

## Learning Vim Motions (Optional but Powerful)

While 0xVim works great with VSCode keybindings, learning Vim motions can supercharge your productivity:

### Basic Motions (worth learning)

| Motion | What it does |
|--------|--------------|
| `h/j/k/l` | Left/Down/Up/Right (alternative to arrows) |
| `w` | Next word |
| `b` | Previous word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `u` | Undo |
| `Ctrl+R` | Redo |

### Combining Motions (advanced)

- `d2w` - Delete 2 words
- `y5j` - Copy 5 lines down
- `ci"` - Change text inside quotes
- `va{` - Select around curly braces

Don't worry! You can use VSCode shortcuts and gradually learn these if interested.

## Modes in Vim (Important!)

Unlike VSCode, Neovim has different modes:

1. **Normal Mode** (default)
   - Navigate and execute commands
   - Press `Esc` to return here from any mode

2. **Insert Mode**
   - Type text like in VSCode
   - Press `i` to enter, or just start typing with VSCode shortcuts
   - Press `Esc` to exit to Normal mode

3. **Visual Mode**
   - Select text
   - Press `v` to enter, or use mouse/Shift+arrows (VSCode style)
   - Execute commands on selection

4. **Command Mode**
   - Run Vim commands
   - Press `:` to enter
   - Example: `:w` to save, `:q` to quit

**Pro Tip:** You can mostly ignore modes and use VSCode shortcuts! The configuration handles mode switching automatically for common operations.

## GitHub Copilot

If you use Copilot in VSCode, it works in 0xVim too!

| Feature | VSCode | 0xVim |
|---------|--------|-------|
| Accept suggestion | `Tab` | `Alt+L` or `Tab` |
| Next suggestion | `Alt+]` | `Alt+]` |
| Previous suggestion | `Alt+[` | `Alt+[` |
| Dismiss | `Esc` | `Ctrl+]` |
| Open Copilot chat | Sidebar | `<leader>cp` |

## Tips for Success

1. **Use the Help Modal**: Press `<leader>?` or `F1` whenever you're stuck
2. **Keep Using VSCode Shortcuts**: Most work identically
3. **Gradual Learning**: Don't try to learn all Vim motions at once
4. **Customize**: Edit `init.lua` to adjust to your preferences
5. **Ask for Help**: Run `:help <topic>` for Neovim documentation

## Common Gotchas

### "Why isn't my text appearing?"

You're in Normal mode. Press `i` to enter Insert mode, or use VSCode shortcuts that automatically switch modes.

### "How do I exit?"

- Save and quit: `:wq` or `Ctrl+S` then `:q`
- Quit without saving: `:q!`
- Or just close the terminal window!

### "Why did Vim open when I wanted VSCode?"

You might have aliased or set Vim as your default editor. Check:
```bash
echo $EDITOR
echo $VISUAL
```

### "Can I use my mouse?"

Yes! Mouse support is enabled. Click, scroll, and select like normal.

## Productivity Gains

Once comfortable, you'll notice these benefits:

1. **Faster Navigation**: Motions are quicker than mouse
2. **Less Context Switching**: Everything in the terminal
3. **Repeatable Actions**: `.` repeats last command
4. **Macros**: Record and replay sequences
5. **Lightweight**: Fast startup, low memory
6. **SSH-Friendly**: Edit on remote servers
7. **Customization**: Unlimited configuration options

## Next Steps

1. ✅ Read this guide
2. 📚 Check out [MAC_INSTALLATION.md](MAC_INSTALLATION.md) if you haven't installed yet
3. 🎨 Explore [THEMES.md](THEMES.md) to customize appearance
4. 📖 Review [HOWTO.md](HOWTO.md) for advanced features
5. 🚀 Start coding and experiment!

Remember: It's okay to use `:q!` and go back to VSCode while learning. The best way to learn is gradual exposure.

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [VSCode to Vim](https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/)

Happy coding! 🎉
