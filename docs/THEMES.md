# 0xVim Themes Guide

A comprehensive guide to all available themes in 0xVim, including screenshots, variants, and keyboard shortcuts for theme management.

## Quick Theme Switching

### Interactive Theme Picker

**Best Way to Choose a Theme:**
```
<leader>tt
```
- Press `Space` then `tt`
- Live preview as you navigate through themes
- Press `Enter` to apply
- Press `Esc` to cancel

### Direct Theme Shortcuts

Quick switch to specific themes without the picker:

| Shortcut | Theme | Description |
|----------|-------|-------------|
| `<leader>tv` | VSCode | Authentic VSCode dark theme |
| `<leader>to` | Tokyo Night | Beautiful night theme |
| `<leader>tc` | Catppuccin | Soothing pastel theme (mocha) |
| `<leader>tD` | Dracula | Dark theme inspired by Dracula |
| `<leader>tn` | Nord | Arctic, north-bluish palette |
| `<leader>tg` | Gruvbox | Retro groove color scheme |

**Note:** `<leader>` means `Space` key

## Available Themes

### 1. VSCode Theme

**Default theme** - Provides an authentic VSCode experience

**Activation:**
```
<leader>tv
```

**Features:**
- Identical to VSCode Dark+ theme
- Familiar colors for VSCode users
- Optimized for long coding sessions
- Supports transparent backgrounds

**Variants:**
- VSCode Dark (default)
- VSCode Light (modify in `init.lua`)

**Best For:**
- Developers migrating from VSCode
- Those who prefer familiar, battle-tested colors
- Professional work environments

---

### 2. Tokyo Night

**A clean, dark theme perfect for late-night coding**

**Activation:**
```
<leader>to
```

**Variants:**
- `night` (default) - Standard dark variant
- `storm` - Deeper, stormier colors
- `moon` - Softer moonlit palette
- `day` - Light variant

**To Change Variant:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
require('tokyonight').setup({
  style = 'storm', -- or 'moon', 'day'
})
```

**Features:**
- Beautiful blue-tinted background
- Excellent contrast
- Easy on the eyes
- Terminal colors support

**Best For:**
- Night owls and late-night coding
- TypeScript/JavaScript developers
- Modern UI preferences

---

### 3. Catppuccin

**Soothing pastel theme with warm, coffee-inspired colors**

**Activation:**
```
<leader>tc
```

**Flavors:**
- `mocha` (default) - Dark brown-tinted
- `macchiato` - Slightly lighter
- `frappe` - Grayish-blue tinted
- `latte` - Light variant

**To Change Flavor:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
require('catppuccin').setup({
  flavour = 'macchiato', -- or 'frappe', 'latte'
})
```

**Features:**
- Soft, pastel colors
- Excellent for reducing eye strain
- Wide plugin integration
- Four beautiful flavors

**Best For:**
- Those who prefer softer colors
- Long coding sessions
- Coffee lovers ☕

---

### 4. Dracula

**Dark theme inspired by the popular Dracula color scheme**

**Activation:**
```
<leader>tD
```

**Features:**
- Purple-tinted dark background
- High contrast colors
- Vibrant syntax highlighting
- Popular across many editors

**Best For:**
- Fans of purple/pink color schemes
- High contrast preferences
- Developers who use Dracula everywhere

---

### 5. Nord

**Arctic, north-bluish color palette**

**Activation:**
```
<leader>tn
```

**Features:**
- Cool blue and icy colors
- Low contrast, easy on eyes
- Consistent across platforms
- Clean, minimal aesthetic

**Customization Options:**
```lua
vim.g.nord_contrast = true      -- Enable sidebar and popup contrast
vim.g.nord_borders = true       -- Enable border highlight
vim.g.nord_italic = true        -- Enable italic comments
```

**Best For:**
- Minimalist developers
- Those who like cool, calm colors
- Arctic/winter theme enthusiasts

---

### 6. Gruvbox

**Retro groove color scheme with warm, earthy tones**

**Activation:**
```
<leader>tg
```

**Variants:**
- Default (medium contrast)
- Hard contrast
- Soft contrast

**To Change Contrast:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
require('gruvbox').setup({
  contrast = 'hard', -- or 'soft', ''
})
```

**Features:**
- Warm, retro colors
- Brown/orange/yellow palette
- Excellent readability
- Vintage aesthetic

**Best For:**
- Retro aesthetics lovers
- Those who prefer warm colors
- Long coding sessions with reduced blue light

---

### 7. OneDark

**Atom's iconic One Dark theme**

**Activation:**
```vim
:colorscheme onedark
```

**Styles:**
- `dark` (default)
- `darker`
- `cool`
- `deep`
- `warm`
- `warmer`

**To Change Style:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
require('onedark').setup {
  style = 'darker', -- or 'cool', 'deep', 'warm', 'warmer'
}
```

**Features:**
- Classic Atom editor colors
- Balanced contrast
- Professional appearance
- Multiple style variants

**Best For:**
- Former Atom users
- Those who like balanced, professional themes
- Developers wanting tried-and-true colors

---

### 8. Kanagawa

**Inspired by the famous "Great Wave off Kanagawa" painting**

**Activation:**
```vim
:colorscheme kanagawa
```

**Themes:**
- `wave` (default)
- `dragon`
- `lotus`

**To Change Theme:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
require('kanagawa').setup({
  theme = 'dragon', -- or 'lotus'
})
```

**Features:**
- Artistic, wave-inspired colors
- Deep blues and greens
- Unique aesthetic
- Multiple theme variants

**Best For:**
- Art and design enthusiasts
- Those who want something unique
- Developers who appreciate Japanese aesthetics

---

### 9. Nightfox

**Highly customizable theme with multiple fox-themed variants**

**Activation:**
```vim
:colorscheme nightfox  " or carbonfox, dawnfox, etc.
```

**Variants:**
- `nightfox` - Standard dark blue
- `dayfox` - Light variant
- `dawnfox` - Dawn colors
- `duskfox` - Dusk colors
- `nordfox` - Nord-inspired
- `terafox` - Greenish tint
- `carbonfox` - Pure dark

**Features:**
- 7+ distinct variants
- Highly customizable
- Modern color science
- Consistent across variants

**Best For:**
- Developers who like options
- Those who switch themes frequently
- Customization enthusiasts

---

### 10. Rose Pine

**All natural pine, faux fur and a bit of soho vibes**

**Activation:**
```vim
:colorscheme rose-pine
```

**Variants:**
- `main` (default) - Standard dark
- `moon` - Darker variant
- `dawn` - Light variant

**To Change Variant:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
require('rose-pine').setup({
  variant = 'moon', -- or 'dawn'
})
```

**Features:**
- Natural, earthy colors
- Soft purples and pinks
- Low blue light
- Three distinct moods

**Best For:**
- Natural color palette lovers
- Evening/night coding
- Developers who prefer muted colors

---

### 11. Material

**Google's Material Design color palette**

**Activation:**
```vim
:colorscheme material
```

**Styles:**
- `darker`
- `lighter`
- `oceanic`
- `palenight`
- `deep ocean`

**To Change Style:**
Edit `~/.config/nvim/lua/custom/plugins/themes.lua`:
```lua
vim.g.material_style = 'oceanic' -- or others
```

**Features:**
- Material Design colors
- Clean, modern aesthetic
- Multiple style variants
- Wide plugin support

**Best For:**
- Material Design fans
- Android developers
- Those who like clean, modern UIs

---

## Theme Management Commands

### Keyboard Shortcuts Summary

```
<leader>tt    - Interactive theme picker (RECOMMENDED)
<leader>tv    - VSCode theme
<leader>to    - Tokyo Night theme
<leader>tc    - Catppuccin theme
<leader>tD    - Dracula theme (capital D)
<leader>tn    - Nord theme
<leader>tg    - Gruvbox theme
```

### Manual Theme Switching

In Neovim command mode (press `:`):

```vim
:colorscheme vscode
:colorscheme tokyonight
:colorscheme catppuccin
:colorscheme dracula
:colorscheme nord
:colorscheme gruvbox
:colorscheme onedark
:colorscheme kanagawa
:colorscheme nightfox
:colorscheme rose-pine
:colorscheme material
```

### Setting a Default Theme

Edit `~/.config/nvim/init.lua` and add near the end:

```lua
vim.cmd.colorscheme 'your-theme-name'
```

Example:
```lua
vim.cmd.colorscheme 'tokyonight'
```

## Theme Customization

### Making Themes Transparent

Most themes support transparent backgrounds. Edit the theme configuration:

```lua
-- Example for Tokyo Night
require('tokyonight').setup({
  transparent = true,
})

-- Example for Catppuccin
require('catppuccin').setup({
  transparent_background = true,
})

-- Example for Gruvbox
require('gruvbox').setup({
  transparent_mode = true,
})
```

### Adjusting Contrast

Some themes allow contrast adjustment:

```lua
-- Gruvbox
require('gruvbox').setup({
  contrast = 'hard', -- or 'soft'
})

-- Nord
vim.g.nord_contrast = true
```

### Custom Highlights

Override specific highlight groups in `~/.config/nvim/init.lua`:

```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    -- Example: Make comments brighter
    vim.api.nvim_set_hl(0, 'Comment', { fg = '#888888', italic = true })
  end,
})
```

## Choosing the Right Theme

### By Use Case

**Professional/Corporate Environment:**
- VSCode
- OneDark
- Material

**Late Night Coding:**
- Tokyo Night (night/moon)
- Dracula
- Nightfox

**Reducing Eye Strain:**
- Catppuccin
- Gruvbox
- Nord

**High Contrast Needs:**
- Dracula
- Gruvbox (hard)
- VSCode

**Light Themes:**
- Tokyo Night (day)
- Catppuccin (latte)
- Rose Pine (dawn)
- Material (lighter)

### By Color Preference

**Blue Tones:**
- Tokyo Night
- Nord
- Nightfox

**Purple/Pink Tones:**
- Dracula
- Rose Pine
- Catppuccin

**Warm/Earthy Tones:**
- Gruvbox
- Kanagawa
- OneDark (warm/warmer)

**Neutral/Balanced:**
- VSCode
- OneDark
- Material

## Advanced: Creating Your Own Theme Shortcut

Add custom theme shortcuts in `~/.config/nvim/init.lua`:

```lua
vim.keymap.set('n', '<leader>tm', function()
  vim.cmd.colorscheme 'material'
end, { desc = 'Switch to Material theme' })
```

## Troubleshooting

### Theme Not Loading

1. Ensure the theme plugin is installed:
   ```
   :Lazy sync
   ```

2. Check for errors:
   ```
   :messages
   ```

3. Verify theme exists:
   ```
   :colorscheme <Tab>
   ```
   (Press Tab to see available themes)

### Colors Look Wrong

1. **Terminal color support:**
   ```lua
   -- Add to init.lua
   vim.opt.termguicolors = true
   ```

2. **Terminal compatibility:**
   - Use a terminal that supports 24-bit color
   - iTerm2, Alacritty, Kitty, WezTerm recommended

3. **Check $TERM variable:**
   ```bash
   echo $TERM
   ```
   Should be `xterm-256color` or better

### Theme Doesn't Match Screenshots

Different terminals render colors slightly differently. For best results:
- Use a modern terminal emulator
- Enable true color support
- Use a Nerd Font

## Recommendations

### For Beginners
Start with **VSCode** theme - it's familiar and well-balanced.

### For Most Users
**Tokyo Night** or **Catppuccin** - beautiful, popular, and easy on the eyes.

### For Customization Fans
**Nightfox** - 7+ variants with extensive customization options.

### For Minimalists
**Nord** - clean, simple, and distraction-free.

## Theme Gallery

### Popular Combinations

**Dark Mode Favorites:**
1. Tokyo Night (night) + JetBrains Mono font
2. Catppuccin (mocha) + Fira Code font
3. Gruvbox + Hack font

**Light Mode Options:**
1. Tokyo Night (day)
2. Catppuccin (latte)
3. Rose Pine (dawn)

**Unique Aesthetics:**
1. Kanagawa - Japanese art-inspired
2. Rose Pine - Natural, earthy
3. Dracula - Bold, vibrant

## Quick Reference Card

```
┌─────────────────────────────────────────────────────┐
│            0xVim Theme Shortcuts                     │
├─────────────────────────────────────────────────────┤
│ <Space>tt  │ Theme picker (live preview)            │
│ <Space>tv  │ VSCode                                 │
│ <Space>to  │ Tokyo Night                            │
│ <Space>tc  │ Catppuccin                             │
│ <Space>tD  │ Dracula                                │
│ <Space>tn  │ Nord                                   │
│ <Space>tg  │ Gruvbox                                │
├─────────────────────────────────────────────────────┤
│ :colorscheme <name>  │ Manual theme switch         │
│ :Telescope themes    │ Alternative picker          │
├─────────────────────────────────────────────────────┤
│ Total Themes: 11+ with 30+ variants                 │
└─────────────────────────────────────────────────────┘
```

## Additional Resources

- [Tokyo Night GitHub](https://github.com/folke/tokyonight.nvim)
- [Catppuccin GitHub](https://github.com/catppuccin/nvim)
- [Awesome Neovim Themes](https://github.com/rockerBOO/awesome-neovim#colorscheme)

Enjoy customizing your 0xVim experience! 🎨
