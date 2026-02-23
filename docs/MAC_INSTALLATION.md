# 0xVim Installation Guide for macOS

This guide provides step-by-step instructions for installing 0xVim on macOS.

## Prerequisites

Before installing 0xVim, ensure you have the following:

- macOS 10.15 (Catalina) or later
- Command Line Tools for Xcode
- [Homebrew](https://brew.sh/) package manager

## Step 1: Install Homebrew (if not already installed)

If you don't have Homebrew installed, open Terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the on-screen instructions to complete the installation.

## Step 2: Install Neovim

0xVim requires Neovim 0.9.0 or later. Install the latest stable version:

```bash
brew install neovim
```

Verify the installation:

```bash
nvim --version
```

## Step 3: Install Required Dependencies

Install essential tools for 0xVim:

```bash
# Core dependencies
brew install git make unzip gcc

# Fuzzy finder and search tools
brew install ripgrep fd

# Optional but recommended
brew install node npm      # For TypeScript/JavaScript development
brew install python3       # For Python development
brew install go            # For Go development
```

## Step 4: Install a Nerd Font

Nerd Fonts provide icons and glyphs for a better experience:

```bash
# Install a popular Nerd Font (choose one or more)
brew tap homebrew/cask-fonts

# Popular options:
brew install --cask font-jetbrains-mono-nerd-font
# or
brew install --cask font-fira-code-nerd-font
# or
brew install --cask font-hack-nerd-font
```

**Configure your terminal:**
- Open your terminal preferences
- Set the font to the Nerd Font you just installed
- Enable the `vim.g.have_nerd_font` setting in init.lua (already enabled by default)

## Step 5: Backup Existing Neovim Configuration (if any)

If you have an existing Neovim configuration, back it up:

```bash
# Backup configuration
mv ~/.config/nvim ~/.config/nvim.backup

# Backup data
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Backup cache
mv ~/.local/state/nvim ~/.local/state/nvim.backup
```

## Step 6: Install 0xVim

### Option A: Clone the Repository (Recommended)

Fork the repository on GitHub first, then clone your fork:

```bash
git clone https://github.com/YOUR_USERNAME/0xVim.git ~/.config/nvim
```

Replace `YOUR_USERNAME` with your GitHub username.

### Option B: Clone the Original Repository

```bash
git clone https://github.com/tacheraSasi/0xVim.git ~/.config/nvim
```

## Step 7: First Launch

Start Neovim to trigger automatic plugin installation:

```bash
nvim
```

**What happens:**
1. Lazy.nvim (plugin manager) will automatically install
2. All plugins will be downloaded and installed
3. TreeSitter parsers will be installed
4. Language servers will be configured

**Wait for all installations to complete** (this may take a few minutes).

## Step 8: Install Language Servers (Optional)

0xVim uses Mason to manage language servers. Inside Neovim:

1. Open Mason: `:Mason`
2. Browse available language servers
3. Install servers for your languages:
   - `i` - Install package
   - `X` - Uninstall package
   - `u` - Update package

Common language servers:
- TypeScript/JavaScript: `typescript-language-server`
- Python: `pyright`
- Go: `gopls`
- Rust: `rust-analyzer`
- Lua: `lua-language-server`

Or install via command line:

```bash
# Inside Neovim
:MasonInstall typescript-language-server pyright gopls rust-analyzer
```

## Step 9: Verify Installation

Check that everything is working:

1. **Open a file:** `nvim test.js`
2. **Test file explorer:** Press `Ctrl+B`
3. **Test fuzzy finder:** Press `Ctrl+P`
4. **Test theme picker:** Press `Space` then `tt`
5. **Check health:** Run `:checkhealth` in Neovim

## Troubleshooting

### Issue: "command not found: nvim"

**Solution:** Make sure Homebrew's bin directory is in your PATH:

```bash
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

For older Macs (Intel):
```bash
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Issue: Icons/glyphs not displaying

**Solution:**
1. Ensure you installed a Nerd Font (Step 4)
2. Configure your terminal to use the Nerd Font
3. Restart your terminal

### Issue: Clipboard not working

**Solution:** macOS clipboard should work out of the box. If not, try:

```bash
# Install pbcopy/pbpaste if missing
brew install pbcopy
```

### Issue: Plugins not installing

**Solution:**
1. Check internet connection
2. Run `:Lazy sync` to retry installation
3. Check `:Lazy log` for error messages

### Issue: Performance issues

**Solution:**
1. Disable unnecessary language servers in Mason
2. Reduce TreeSitter parsers to only needed languages
3. Check background processes with Activity Monitor

## Next Steps

- Read [VSCODE_MIGRATION.md](VSCODE_MIGRATION.md) if you're coming from VSCode
- Explore [THEMES.md](THEMES.md) to customize your color scheme
- Check [HOWTO.md](HOWTO.md) for a comprehensive usage guide
- Press `<leader>?` or `F1` inside Neovim for the interactive help modal

## Updating 0xVim

To update your 0xVim installation:

```bash
cd ~/.config/nvim
git pull
```

Then inside Neovim, update plugins:

```
:Lazy sync
```

## Uninstalling

To completely remove 0xVim:

```bash
# Remove configuration
rm -rf ~/.config/nvim

# Remove data
rm -rf ~/.local/share/nvim

# Remove cache
rm -rf ~/.local/state/nvim

# Restore backup (if you made one)
mv ~/.config/nvim.backup ~/.config/nvim
mv ~/.local/share/nvim.backup ~/.local/share/nvim
mv ~/.local/state/nvim.backup ~/.local/state/nvim
```

## Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Homebrew Documentation](https://docs.brew.sh/)
- [0xVim GitHub Repository](https://github.com/tacheraSasi/0xVim)

Enjoy your new Neovim setup! 🚀
