# How-To Modal Preview

When you press `<leader>?` or `F1`, you'll see a beautiful floating window like this:

```
╔═══════════════════════════════════════════════════════════════════════════╗
║                     NEOVIM QUICK REFERENCE GUIDE                          ║
╚═══════════════════════════════════════════════════════════════════════════╝

┌─ FILE OPERATIONS ────────────────────────────────────────────────────────┐
│ <Ctrl+S>          Save current file                                      │
│ <Ctrl+Shift+S>    Save all files                                         │
│ <Ctrl+P>          Quick open files (fuzzy finder)                        │
│ <Ctrl+Shift+P>    Command palette                                        │
│ <Ctrl+B>          Toggle file explorer sidebar                           │
│ <Ctrl+Shift+E>    Toggle file explorer sidebar (alternative)             │
│ <Ctrl+N>          New file                                               │
│ <Ctrl+W>          Close current buffer                                   │
└──────────────────────────────────────────────────────────────────────────┘

┌─ EDITING ────────────────────────────────────────────────────────────────┐
│ <Ctrl+Z>          Undo                                                    │
│ <Ctrl+Y>          Redo                                                    │
│ <Ctrl+C>          Copy (in visual mode)                                  │
│ <Ctrl+X>          Cut (in visual mode)                                   │
│ <Ctrl+V>          Paste                                                   │
│ <Ctrl+A>          Select all                                             │
│ <Ctrl+/>          Toggle line comment                                    │
│ <Ctrl+D>          Multi-cursor: select next occurrence                   │
│ <Alt+Up/Down>     Move line up/down                                      │
│ <Ctrl+Shift+K>    Delete line                                            │
└──────────────────────────────────────────────────────────────────────────┘

... (more sections)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Press <q> or <Esc> to close this window                                  
  Press <Space> to see more keybindings with Which-Key                     
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Features

- **Comprehensive**: 120+ commands organized by category
- **Beautiful**: Box-drawing characters for clean formatting
- **Easy to use**: 
  - Open: `<leader>?` or `F1`
  - Close: `q` or `<Esc>`
  - More help: Press `Space` for which-key
- **Categories include**:
  - File Operations
  - Editing
  - Search & Navigation
  - Window Management
  - Terminal
  - Code Intelligence
  - Git Integration
  - Special Features
  - GitHub Copilot
  - Basic Vim Motions

## Size

The modal takes up 85% of your editor's width and height, with:
- Rounded borders
- Centered title
- Scrollable content
- Syntax highlighting

Perfect for when you can't remember a keybinding!
