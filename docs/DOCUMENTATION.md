# 0xVim Documentation Index

Welcome to 0xVim! This index will help you find the right documentation for your needs.

## 🚀 Getting Started

### New Installation

1. **[MAC_INSTALLATION.md](MAC_INSTALLATION.md)** - Complete macOS installation guide
   - Homebrew setup
   - Neovim installation
   - Dependencies and fonts
   - Step-by-step installation
   - Troubleshooting common issues

2. **[README.md](README.md)** - Main project overview
   - Quick installation for all platforms
   - Feature overview
   - Basic setup instructions

### Migrating from VSCode

**[VSCODE_MIGRATION.md](VSCODE_MIGRATION.md)** - Essential guide for VSCode users
- VSCode to 0xVim keybinding mappings
- Common workflows translated
- Feature comparison
- Tips for smooth transition
- Learning Vim motions (optional)

## 📖 Usage Guides

### Daily Use

**[HOWTO.md](HOWTO.md)** - Comprehensive usage guide
- File management
- Code editing
- Navigation
- Git integration
- All keyboard shortcuts
- Plugin features

### Interactive Help

**Inside Neovim:**
- Press `<leader>?` or `F1` for interactive help modal
- Press `Space` and wait for which-key menu

## 🎨 Customization

### Themes

**[THEMES.md](THEMES.md)** - Complete theme reference
- 11+ themes with 30+ variants
- Theme previews and descriptions
- Keyboard shortcuts for switching
- Customization options
- Recommendations by use case

## 📚 Reference Documentation

### Features

**[FEATURES.md](FEATURES.md)** - Detailed feature documentation
- VSCode-like features
- Language support
- Git integration
- Advanced capabilities

### Additional Resources

- **[VISUAL_GUIDE.md](VISUAL_GUIDE.md)** - Visual walkthrough
- **[HOWTO_MODAL_PREVIEW.md](HOWTO_MODAL_PREVIEW.md)** - Help modal reference

## 🎯 Quick Navigation

| I want to... | Go to... |
|--------------|----------|
| Install on Mac | [MAC_INSTALLATION.md](MAC_INSTALLATION.md) |
| Migrate from VSCode | [VSCODE_MIGRATION.md](VSCODE_MIGRATION.md) |
| Learn keyboard shortcuts | [HOWTO.md](HOWTO.md) or press `<leader>?` in Neovim |
| Change themes | [THEMES.md](THEMES.md) |
| Understand features | [FEATURES.md](FEATURES.md) |
| Troubleshoot | [MAC_INSTALLATION.md#troubleshooting](MAC_INSTALLATION.md#troubleshooting) |
| Customize settings | Edit `~/.config/nvim/init.lua` |

## 🆘 Getting Help

1. **First:** Press `<leader>?` or `F1` inside Neovim for interactive help
2. **For installation issues:** See [MAC_INSTALLATION.md#troubleshooting](MAC_INSTALLATION.md#troubleshooting)
3. **For VSCode comparisons:** See [VSCODE_MIGRATION.md](VSCODE_MIGRATION.md)
4. **For feature questions:** See [HOWTO.md](HOWTO.md)
5. **Neovim help:** Type `:help <topic>` inside Neovim

## 📝 Documentation Organization

```
0xVim/
├── README.md                  # Main overview & quick start
├── MAC_INSTALLATION.md        # macOS installation guide
├── VSCODE_MIGRATION.md        # VSCode user guide
├── THEMES.md                  # Theme reference
├── HOWTO.md                   # Usage guide
├── FEATURES.md                # Feature documentation
└── init.lua                   # Main configuration file
```

## 🔗 External Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [0xVim GitHub Repository](https://github.com/tacheraSasi/0xVim)

---

**Recommended Reading Order:**

1. **First Time Users:**
   - MAC_INSTALLATION.md (if on Mac)
   - VSCODE_MIGRATION.md (if coming from VSCode)
   - HOWTO.md

2. **Experienced Vim Users:**
   - README.md
   - FEATURES.md
   - THEMES.md

3. **Customization:**
   - THEMES.md
   - Edit `init.lua` and files in `lua/custom/`

Happy coding! 🚀
