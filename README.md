# kickstart.nvim

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> [!NOTE]
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> [!NOTE]
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### Enhanced Features

### Enhanced Features

#### VSCode-like Features
This configuration provides a comprehensive VSCode-like experience with the following features:

**File Management:**
- **File Explorer**: Neo-tree with `Ctrl+B` to toggle (like VSCode sidebar)
- **Quick Open**: `Ctrl+P` for quick file finder (like VSCode Quick Open) - **Enhanced with smart filtering**
  - Automatically excludes build artifacts (`dist/`, `build/`, `target/`)
  - Filters out dependencies (`node_modules/`, `vendor/`, `__pycache__/`)
  - Hides IDE/OS files (`.vscode/`, `.idea/`, `.DS_Store`, etc.)
  - Reduces noise by up to 65% while preserving access to relevant files
- **Command Palette**: `Ctrl+Shift+P` for command palette access

**Editing Experience:**
- **GitHub Copilot**: AI-powered code completion and suggestions (`Alt+L` to accept)
- **Multi-cursor Support**: `Ctrl+D` to add selection to next find match
- **Smart Auto-pairs**: Automatic bracket, quote, and tag pairing
- **Auto-completion**: Intelligent code completion with snippets (less intrusive documentation)
- **Line Operations**: Move lines with `Alt+Up/Down`, delete with `Ctrl+Shift+K`
- **Comment Toggle**: `Ctrl+/` for line comments, `Ctrl+Shift+/` for block comments

**Search and Replace:**
- **Find in File**: `Ctrl+F` for current file search
- **Replace in File**: `Ctrl+H` for current file replace
- **Find in Files**: `Ctrl+Shift+F` for project-wide search
- **Replace in Files**: `Ctrl+Shift+H` for project-wide replace with Spectre

**Navigation:**
- **Go to Line**: `Ctrl+G` for quick line navigation
- **Go to Symbol**: `Ctrl+T` for workspace symbols
- **Breadcrumbs**: File path and symbol navigation in status bar
- **Minimap**: Code overview panel (toggle with `<leader>mm`)

**Git Integration:**
- **Git Status**: Integrated git signs in gutter
- **Git Blame**: Line-by-line git blame information
- **Git Operations**: Stage hunks, reset changes, view diffs
- **Git UI**: Full git interface with Neogit (`<leader>gg`)

**Language Support:**
- **LSP Integration**: Full Language Server Protocol support for:
  - TypeScript/JavaScript with import organization
  - Python with auto-imports and type checking
  - Go with import management
  - Rust with advanced features
  - Java with import organization
  - HTML/CSS, JSON, YAML, Markdown, and more
- **Auto-formatting**: Format on save with language-specific formatters
- **Linting**: Real-time error detection and suggestions
- **IntelliSense**: Smart code completion and suggestions

**Terminal Integration:**
- **Integrated Terminal**: `Ctrl+\`` to toggle floating terminal
- **New Terminal**: `Ctrl+Shift+\`` for new terminal instance

**UI/UX:**
- **VSCode Theme**: Authentic VSCode color scheme
- **Status Line**: Comprehensive status bar with git, diagnostics, and location
- **Indentation Guides**: Visual indentation helpers
- **Folding**: Smart code folding with preview
- **Zen Mode**: Distraction-free coding mode (`Ctrl+K Z`)

#### Complete VSCode Keybinding Reference

**File Operations:**
- `Ctrl+S` - Save file
- `Ctrl+Shift+S` - Save all files
- `Ctrl+P` - Quick Open Files
- `Ctrl+Shift+P` - Command Palette
- `Ctrl+W` - Close editor
- `Ctrl+Shift+T` - Reopen closed editor
- `Ctrl+Shift+N` - New window

**Editing:**
- `Ctrl+Z` - Undo
- `Ctrl+Y` - Redo
- `Ctrl+X` - Cut
- `Ctrl+C` - Copy
- `Ctrl+V` - Paste
- `Ctrl+A` - Select all
- `Ctrl+D` - Add selection to next find match
- `Ctrl+Shift+K` - Delete line
- `Ctrl+Enter` - Insert line below
- `Ctrl+Shift+Enter` - Insert line above
- `Alt+Up/Down` - Move line up/down

**Search and Navigation:**
- `Ctrl+F` - Find in current file
- `Ctrl+H` - Replace in current file
- `Ctrl+Shift+F` - Find in files
- `Ctrl+Shift+H` - Replace in files
- `Ctrl+G` - Go to line
- `Ctrl+T` - Go to symbol in workspace
- `F12` - Go to definition
- `Shift+F12` - Find all references
- `F2` - Rename symbol
- `Alt+F12` - Peek definition

**Code Actions:**
- `Ctrl+.` - Quick fix
- `Ctrl+/` - Toggle line comment
- `Ctrl+Shift+/` - Toggle block comment
- `Ctrl+]` - Indent
- `Ctrl+[` - Outdent
- `Alt+Shift+F` - Format document

**Window Management:**
- `Ctrl+B` - Toggle file explorer
- `Ctrl+\`` - Toggle terminal
- `Ctrl+Shift+\`` - New terminal
- `Ctrl+\\` - Split editor right
- `Ctrl+K Ctrl+\\` - Split editor down
- `Ctrl+Tab` - Next editor
- `Ctrl+Shift+Tab` - Previous editor

**Problems and Diagnostics:**
- `F8` - Next problem
- `Shift+F8` - Previous problem
- `Ctrl+Shift+M` - Show problems panel

**Folding:**
- `Ctrl+Shift+[` - Fold
- `Ctrl+Shift+]` - Unfold
- `Ctrl+K Ctrl+0` - Fold all
- `Ctrl+K Ctrl+J` - Unfold all

**Special Features:**
- `Ctrl+K Z` - Toggle Zen mode
- `<leader>mm` - Toggle minimap
- `<leader>gg` - Open git interface
- `<leader>gb` - Toggle git blame

**GitHub Copilot:**
- `Alt+L` - Accept Copilot suggestion
- `Alt+]` - Next Copilot suggestion
- `Alt+[` - Previous Copilot suggestion
- `Ctrl+]` - Dismiss Copilot suggestion
- `<leader>cp` - Open Copilot panel
- `<leader>cs` - Show Copilot status
- `<leader>ce` - Enable Copilot
- `<leader>cd` - Disable Copilot

**Completion & Documentation:**
- `Ctrl+Space` - Show completion menu manually
- `<leader>td` - Toggle documentation window

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

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

