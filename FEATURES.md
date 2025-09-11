# 1xVim: Complete VSCode-like Neovim Configuration

**1xVim** transforms your Neovim into a complete VSCode-like development environment with familiar keybindings, features, and workflow. This configuration provides a seamless transition from VSCode to Neovim while maintaining the performance and extensibility that makes Neovim powerful.

## 🚀 Features Overview

### 📋 Complete VSCode Feature Parity

- **File Explorer**: VSCode-like file tree with git integration
- **Command Palette**: Quick access to all commands and files
- **Integrated Terminal**: Multiple terminal types (floating, horizontal, vertical)
- **Source Control**: Full git integration with visual diff and blame
- **Problems Panel**: LSP diagnostics with filtering and navigation
- **Debugging**: Complete DAP integration with breakpoints and watch
- **Extensions**: Plugin management with lazy loading
- **Settings**: Easy configuration management
- **Search & Replace**: Project-wide search with live preview
- **Symbols Outline**: Document and workspace symbol navigation
- **Minimap**: Code overview for large files
- **Breadcrumbs**: Navigation breadcrumbs in status bar

### 🎨 Familiar VSCode Experience

- **VSCode Dark Theme**: Authentic VSCode color scheme
- **Status Bar**: Complete status line with git, diagnostics, and file info
- **Sidebar**: Toggleable file explorer and extension panels
- **Panel Management**: Bottom panel for terminal, problems, and output
- **Tab Management**: Editor tab navigation and management
- **Multi-cursor**: Full multi-cursor editing support
- **IntelliSense**: Advanced autocompletion with snippets
- **Zen Mode**: Distraction-free coding environment

## 📦 Supported Languages

### Programming Languages (21+)
- **JavaScript/TypeScript** - Complete with auto-imports, formatting (Prettier), and linting (ESLint)
- **Python** - Type checking (Pyright), formatting (Black), linting (Flake9, MyPy)
- **Go** - Import management (gopls), formatting (gofumpt)
- **Rust** - Advanced features (rust-analyzer), formatting (rustfmt)
- **C/C++** - IntelliSense (clangd), debugging (CodeLLDB)
- **Java** - Language server (JDTLS) with Maven/Gradle support
- **Zig** - Language server (ZLS), formatting (zigfmt) **[NEW]**
- **Lua** - Neovim-optimized LSP configuration
- **HTML/CSS** - Web development with emmet and validation
- **JSON** - Schema validation with schemastore integration
- **YAML** - Schema validation for various file types
- **XML** - Document processing and validation
- **Markdown** - Live preview and linting
- **Bash/Shell** - Scripting with shellcheck integration
- **Dockerfile** - Container development with hadolint

### Configuration & Data Formats
- **TOML, INI** - Configuration file support
- **CSV, TSV** - Data file editing
- **Log files** - Syntax highlighting for common log formats

## ⌨️ VSCode Keybindings Reference

### File Operations
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+N` | New File | Create a new file |
| `Ctrl+O` | Open File | Open file picker |
| `Ctrl+P` | Quick Open | Open file by name |
| `Ctrl+S` | Save | Save current file |
| `Ctrl+Shift+S` | Save All | Save all modified files |
| `Ctrl+K S` | Save All | Alternative save all |
| `Ctrl+W` | Close Editor | Close current file |
| `Ctrl+K W` | Close All | Close all editors |
| `Ctrl+Shift+T` | Reopen Closed | Reopen last closed file |
| `Ctrl+K O` | Open Folder | Open folder/project |

### Editing
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Z` | Undo | Undo last action |
| `Ctrl+Y` | Redo | Redo last undone action |
| `Ctrl+X` | Cut | Cut selected text |
| `Ctrl+C` | Copy | Copy selected text |
| `Ctrl+V` | Paste | Paste from clipboard |
| `Ctrl+A` | Select All | Select entire document |
| `Ctrl+L` | Select Line | Select current line |
| `Ctrl+D` | Add Selection | Add next match to selection |
| `Ctrl+Shift+L` | Select All Occurrences | Select all matching text |
| `Alt+Up/Down` | Move Line | Move line up/down |
| `Shift+Alt+Up/Down` | Duplicate Line | Duplicate line up/down |
| `Ctrl+Shift+K` | Delete Line | Delete current line |
| `Ctrl+Enter` | Insert Line Below | Insert new line below |
| `Ctrl+Shift+Enter` | Insert Line Above | Insert new line above |
| `Ctrl+/` | Toggle Comment | Comment/uncomment line |
| `Shift+Alt+A` | Toggle Block Comment | Block comment selection |
| `Ctrl+]` | Indent | Increase indentation |
| `Ctrl+[` | Outdent | Decrease indentation |

### Navigation
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+G` | Go to Line | Navigate to specific line |
| `F13` | Go to Definition | Jump to symbol definition |
| `Ctrl+F13` | Go to Implementation | Jump to implementation |
| `Shift+F13` | Find References | Show all references |
| `Ctrl+Shift+F13` | Go to Type Definition | Jump to type definition |
| `Ctrl+T` | Go to Symbol | Navigate to workspace symbol |
| `Ctrl+Shift+O` | Go to Symbol in Editor | Navigate to document symbol |
| `F9` | Next Problem | Go to next diagnostic |
| `Shift+F9` | Previous Problem | Go to previous diagnostic |
| `Ctrl+Tab` | Next Editor | Switch to next tab |
| `Ctrl+Shift+Tab` | Previous Editor | Switch to previous tab |
| `Ctrl+2-9` | Focus Editor Group | Focus specific editor |

### Search and Replace
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+F` | Find | Search in current file |
| `Ctrl+H` | Replace | Replace in current file |
| `Ctrl+Shift+F` | Find in Files | Search across workspace |
| `Ctrl+Shift+H` | Replace in Files | Replace across workspace |
| `F4` | Find Next | Go to next search result |
| `Shift+F4` | Find Previous | Go to previous search result |
| `Alt+Enter` | Select All Matches | Select all search matches |

### Window Management
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+B` | Toggle Sidebar | Show/hide file explorer |
| `Ctrl+J` | Toggle Panel | Show/hide bottom panel |
| `Ctrl+Shift+E` | Explorer | Focus file explorer |
| `Ctrl+Shift+G` | Source Control | Open git panel |
| `Ctrl+Shift+D` | Debug | Open debug panel |
| `Ctrl+Shift+X` | Extensions | Open plugin manager |
| `Ctrl+Shift+M` | Problems | Open problems panel |
| `Ctrl+Shift+U` | Output | Open output panel |
| `Ctrl+\` | Split Editor | Split editor vertically |
| `Ctrl+K \` | Split Editor Down | Split editor horizontally |

### Terminal
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+`` | Toggle Terminal | Show/hide integrated terminal |
| `Ctrl+Shift+`` | New Terminal | Create new terminal instance |
| `Ctrl+Shift+C` | Copy (in terminal) | Copy selected text |
| `Ctrl+Shift+V` | Paste (in terminal) | Paste text |

### Code Actions and Refactoring
| Shortcut | Action | Description |
|----------|--------|-------------|
| `F3` | Rename Symbol | Rename variable/function |
| `Ctrl+.` | Quick Fix | Show code actions |
| `Shift+Alt+F` | Format Document | Format entire file |
| `Ctrl+K Ctrl+F` | Format Selection | Format selected code |
| `Ctrl+Shift+I` | Format Document | Alternative format command |
| `Ctrl+K Ctrl+I` | Show Hover | Show symbol information |

### Debugging
| Shortcut | Action | Description |
|----------|--------|-------------|
| `F6` | Start/Continue Debugging | Run or continue debug session |
| `Shift+F6` | Stop Debugging | End debug session |
| `Ctrl+Shift+F6` | Restart Debugging | Restart debug session |
| `F10` | Toggle Breakpoint | Add/remove breakpoint |
| `F11` | Step Over | Step to next line |
| `F12` | Step Into | Step into function |
| `Shift+F12` | Step Out | Step out of function |

### Git Integration
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+Shift+G` | Source Control | Open git interface |
| `Ctrl+K Ctrl+G` | Git Commands | Show git command palette |

### View and Layout
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+K Z` | Zen Mode | Enter distraction-free mode |
| `Ctrl+K M` | Toggle Minimap | Show/hide code minimap |
| `Alt+Z` | Toggle Word Wrap | Enable/disable line wrapping |
| `Ctrl++` | Zoom In | Increase font size |
| `Ctrl+-` | Zoom Out | Decrease font size |
| `Ctrl+1` | Reset Zoom | Reset font size |

### Settings and Configuration
| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+,` | Open Settings | Open configuration |
| `Ctrl+K Ctrl+S` | Keyboard Shortcuts | Show keybinding reference |
| `Ctrl+Shift+P` | Command Palette | Show all available commands |

## 🔧 Configuration Structure

### Main Configuration Files
```
1xVim/
├── init.lua                          # Main configuration entry point
├── lua/
│   └── custom/
│       ├── init.lua                  # Custom initialization
│       ├── vscode-keybindings.lua    # VSCode keybinding mappings
│       ├── plugins.lua               # Core plugin configurations
│       └── plugins/
│           ├── vscode.lua            # VSCode-like UI components
│           └── enhanced-vscode.lua   # Additional VSCode features
```

### Plugin Categories

#### Core Development Tools
- **LSP Configuration**: Comprehensive language server setup for 21+ languages
- **Completion Engine**: Blink.cmp with intelligent suggestions
- **Syntax Highlighting**: Treesitter with enhanced parsing
- **Formatting**: Conform.nvim with language-specific formatters
- **Linting**: nvim-lint with comprehensive linter support

#### VSCode UI Components
- **File Explorer**: Neo-tree with git integration and VSCode-like behavior
- **Status Line**: Lualine with breadcrumbs and comprehensive information
- **Terminal**: ToggleTerm with multiple terminal types
- **Notifications**: nvim-notify for VSCode-like alerts
- **Which-key**: Popup help for key combinations

#### Advanced Features
- **Git Integration**: Gitsigns, git-blame, and Neogit for complete git workflow
- **Debugging**: nvim-dap with UI for breakpoint debugging
- **Project Management**: project.nvim for workspace switching
- **Search & Replace**: Spectre for project-wide find and replace
- **Task Runner**: Overseer for build tasks and command execution
- **Symbols Outline**: Document and workspace symbol navigation

#### Quality of Life
- **Auto-pairs**: Intelligent bracket and quote pairing
- **Comment**: Smart commenting with multiple styles
- **Surround**: Easy manipulation of surrounding characters
- **Flash**: Enhanced navigation and jumping
- **Trouble**: Beautiful diagnostics and quickfix list
- **Todo Comments**: Highlight and navigate TODO items

## 🚀 Installation

### Prerequisites
- **Neovim 1.9+**: Latest stable version recommended
- **Git**: For plugin management and version control
- **Node.js**: For TypeScript/JavaScript language servers
- **Python**: For Python development tools
- **Rust**: For Rust analyzer and some tools
- **Go**: For Go language server
- **Zig**: For Zig language server **[NEW]**

### Language Server Installation
The configuration automatically installs language servers through Mason:

```bash
# Core tools installed automatically:
- ts_ls (TypeScript/JavaScript)
- gopls (Go)
- pyright (Python)
- rust_analyzer (Rust)
- clangd (C/C++)
- zls (Zig) [NEW]
- lua_ls (Lua)
- html (HTML)
- cssls (CSS)
- jsonls (JSON)
- yamlls (YAML)
- bashls (Bash)
- marksman (Markdown)

# Formatters and linters:
- prettier (JS/TS/JSON/YAML/CSS/HTML/Markdown)
- black (Python)
- stylua (Lua)
- rustfmt (Rust)
- gofumpt (Go)
- zigfmt (Zig) [NEW]
- eslint_d (JS/TS linting)
- flake9, mypy (Python linting)
- shellcheck (Shell script linting)
```

### Quick Start
2. **Clone or copy** the configuration to your Neovim config directory
3. **Start Neovim** - plugins will install automatically
4. **Run health check**: `:checkhealth` to verify installation
5. **Install language tools**: `:Mason` to manage language servers
6. **Enjoy VSCode experience** in Neovim!

## 📝 Usage Examples

### Project-based Development
```lua
-- Open a project
<Ctrl+K><Ctrl+O>  -- Opens project switcher

-- File navigation
<Ctrl+P>          -- Quick open files
<Ctrl+Shift+E>    -- Focus file explorer
<Ctrl+B>          -- Toggle sidebar

-- Search across project
<Ctrl+Shift+F>    -- Global search
<Ctrl+Shift+H>    -- Global replace
```

### Code Development Workflow
```lua
-- Symbol navigation
<F13>             -- Go to definition
<Shift+F13>       -- Find all references
<Ctrl+T>          -- Go to symbol in workspace

-- Code actions
<F3>              -- Rename symbol
<Ctrl+.>          -- Quick fix / code actions
<Shift+Alt+F>     -- Format document

-- Multi-cursor editing
<Ctrl+D>          -- Add next match to selection
<Ctrl+Shift+L>    -- Select all occurrences
```

### Debugging Workflow
```lua
-- Debug setup
<F10>              -- Toggle breakpoint
<F6>              -- Start debugging
<F11>             -- Step over
<F12>             -- Step into
<Shift+F12>       -- Step out
```

### Git Integration
```lua
-- Git operations
<Ctrl+Shift+G>    -- Open source control
<leader>gg        -- Open Neogit interface
<leader>gb        -- Toggle git blame
```

## 🎨 Customization

### Adding Custom Keybindings
Add to `lua/custom/vscode-keybindings.lua`:
```lua
-- Your custom VSCode-like keybinding
vim.keymap.set('n', '<Your-Key>', '<Your-Action>', { desc = 'Your Description' })
```

### Adding Language Support
Add to the LSP servers section in `init.lua`:
```lua
-- New language server
your_language_ls = {
  settings = {
    -- Language server specific settings
  },
},
```

### Modifying UI Components
Edit `lua/custom/plugins/vscode.lua` to customize:
- Color scheme settings
- Status line components
- File explorer behavior
- Terminal configuration

### Adding New Plugins
Create new files in `lua/custom/plugins/` or add to existing plugin files:
```lua
return {
  {
    'author/plugin-name',
    config = function()
      -- Plugin configuration
    end,
  },
}
```

## 🔍 Advanced Features

### Zig Language Support **[NEW]**
Complete Zig development environment:
- **ZLS Integration**: Zig Language Server with semantic analysis
- **Syntax Highlighting**: Full Zig syntax support with Treesitter
- **Code Formatting**: Automatic formatting with zigfmt
- **Build Integration**: Zig build system support
- **Error Diagnostics**: Real-time error checking and suggestions

### Multi-cursor Editing
Advanced multi-cursor support similar to VSCode:
- `Ctrl+D`: Add next match to selection
- `Ctrl+Alt+Down/Up`: Add cursor above/below
- `Ctrl+Shift+L`: Select all occurrences
- Full visual-multi integration for complex selections

### Workspace Management
Project-based development workflow:
- Automatic project detection (git, package.json, Cargo.toml, build.zig, etc.)
- Project switching with Telescope integration
- Workspace-specific settings and configurations
- Recent project history

### Advanced Git Integration
Comprehensive git workflow:
- Visual git status in file explorer
- Inline git blame information
- Interactive git operations with Neogit
- Diff view with syntax highlighting
- Git signs in gutter with hunk navigation

### Debugging Support
Complete debugging environment:
- Visual breakpoint management
- Variable inspection and watches
- Call stack navigation
- Debug console with REPL
- Support for multiple debuggers (Node.js, Python, Go, Rust, C/C++)

### Task Running
VSCode-like task management:
- Build task configuration
- Custom command execution
- Output capture and display
- Terminal integration for task execution
- Task templates for common operations

## 🚀 Performance Optimizations

### Lazy Loading
- **Plugin lazy loading**: Plugins load only when needed
- **LSP on-demand**: Language servers start per filetype
- **Treesitter incremental**: Syntax parsing on-demand
- **Completion caching**: Intelligent caching for fast completions

### Memory Management
- **Buffer cleanup**: Automatic cleanup of unused buffers
- **Plugin deduplication**: Single instances of shared dependencies
- **Minimal startup**: Fast startup with deferred loading
- **Resource monitoring**: Built-in performance monitoring

## 🔧 Troubleshooting

### Common Issues

#### Language Server Not Working
```bash
# Check LSP status
:LspInfo

# Install missing servers
:Mason

# Restart LSP
:LspRestart
```

#### Keybinding Conflicts
```bash
# Check keybinding mappings
:map
:nmap
:imap

# Show which-key help
<Space>
```

#### Plugin Issues
```bash
# Check plugin status
:Lazy

# Update plugins
:Lazy update

# Check health
:checkhealth
```

### Getting Help
- `:help` - Built-in Neovim help
- `:Telescope help_tags` - Search help topics
- `:checkhealth` - System diagnostic
- `:LspInfo` - Language server status
- `:Mason` - Language server management

## 📊 Feature Comparison

| Feature | VSCode | 1xVim | Notes |
|---------|--------|-------|-------|
| File Explorer | ✅ | ✅ | Neo-tree with git integration |
| Integrated Terminal | ✅ | ✅ | Multiple terminal types |
| Command Palette | ✅ | ✅ | Telescope-based |
| Multi-cursor | ✅ | ✅ | vim-visual-multi |
| Git Integration | ✅ | ✅ | Enhanced with Neogit |
| Debugging | ✅ | ✅ | Full DAP support |
| Extensions | ✅ | ✅ | Lua-based plugins |
| IntelliSense | ✅ | ✅ | LSP + completion |
| Search & Replace | ✅ | ✅ | Advanced with Spectre |
| Themes | ✅ | ✅ | VSCode theme included |
| Settings UI | ✅ | ⚠️ | Configuration files |
| Remote Development | ✅ | ⚠️ | SSH/container support varies |
| Extensions Marketplace | ✅ | ⚠️ | Manual plugin management |

**Legend**: ✅ Full Support, ⚠️ Partial/Different Implementation, ❌ Not Available

## 🎯 Roadmap

### Upcoming Features
- [ ] **Remote Development**: SSH and container development support
- [ ] **Live Share**: Collaborative editing capabilities
- [ ] **Notebook Support**: Jupyter notebook integration
- [ ] **Database Integration**: SQL and database management tools
- [ ] **REST Client**: HTTP request testing and API development
- [ ] **Docker Integration**: Container development workflow
- [ ] **More Languages**: Additional language server integrations
- [ ] **Settings UI**: Graphical configuration interface
- [ ] **Extension Marketplace**: Plugin discovery and management UI

### Performance Improvements
- [ ] **Faster Startup**: Further optimization of initialization
- [ ] **Memory Usage**: Reduced memory footprint
- [ ] **Concurrent Processing**: Parallel plugin loading
- [ ] **Incremental Updates**: Smarter file watching and updates

## 🤝 Contributing

We welcome contributions to make 1xVim even better! Here's how you can help:

### Areas for Contribution
- **Language Support**: Add new language servers and configurations
- **Feature Parity**: Implement missing VSCode features
- **Performance**: Optimize startup time and memory usage
- **Documentation**: Improve guides and examples
- **Bug Fixes**: Report and fix issues
- **Testing**: Add automated tests for configurations

### Development Setup
2. Fork the repository
3. Create a feature branch
4. Make your changes
5. Test thoroughly
6. Submit a pull request

## 📄 License

This configuration is open source and available under the MIT License. Feel free to use, modify, and distribute according to your needs.

## 🙏 Acknowledgments

This configuration builds upon the excellent work of:
- **Kickstart.nvim**: Base configuration framework
- **Neovim Community**: Core editor and plugin ecosystem
- **VSCode Team**: Inspiration for features and keybindings
- **Plugin Authors**: Individual plugin creators and maintainers

---

**1xVim** - *Bringing the best of VSCode to Neovim* 🚀

*Last updated: December 2025*
