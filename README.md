<h1 align="center">Neovimfiles</h1>

<div align="center">
  <a href="https://github.com/ellisonleao/neovimfiles/#install">Install</a>
  <span> • </span>
  <a href="https://github.com/ellisonleao/neovimfiles/#overview">Overview</a>
  <p></p>
</div>

<div align="center">
	
![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)

</div>

Welcome to my Neovim configuration! This project aims to show everyone what a Lua configuration for Neovim looks like.
Feel free to open issues if you have suggestions or improvements. This is an ongoing project and I am constantly making
changes and experimenting new things. Also if you enjoy live coding sessions, please check out my [twitch channel](https://twitch.tv/ellisonleao)

# Install

**Prerequisites**

- Neovim 0.5

Steps:

1. Clone the project in your config folder, usually `~/.config/nvim`:

```bash
$ git clone https://github.com/ellisonleao/neovimfiles ~/.config/nvim
```

2. Open Neovim. You should see a _"Downloading packer.."_ and then _"plugins installed"_ message in the first run

# Overview

## Plugins

Below the list of the current plugins used in this configuration and how we are using them

### Visual

- [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua) - A high-performance color highlighter for Neovim
- [tokyonight](https://github.com/folke/tokyonight.nvim) - Main colorscheme
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) - web devicons for general usage. Used in buffer tabs, statusline and telescope
- [vim-startify](https://github.com/mhinz/vim-startify) - Our main starting screen
- [lualine.nvim](https://github.com/shadmansaleh/lualine.nvim) - Our statusline
- [nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua) - Buffers as tabs, simulating GUIs from other

### Git

- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Still one of the best git plugins ever made for vim
- [vim-rhubarb](https://github.com/tpope/vim-rhubarb) - A companion plugin for vim-fugitive. Open Github urls directly from vim
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show git signs in buffer
- [octo.nvim](https://github.com/pwntester/octo.nvim) -Edit and review GitHub issues and pull requests from Neovim

### Utils

- [vim-surround](https://github.com/tpope/vim-surround) - easily add or remove strings "surroundings" chars
- [vim-repeat](https://github.com/tpope/vim-repeat) - Puts the `.` repeat char into another level
- [Comment](https://github.com/numToStr/Comment.nvim) - Shortcut for commenting in and out code snippets
- [formatter.nvim](https://github.com/mhartington/formatter.nvim) - General Format code on save tool
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Easy default configs for the builtin LSP client
- [trouble.nvim](https://github.com/folke/trouble.nvim) - Better UI for Errors and LSP outputs (docs, references, errors)
- [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) - Easy install LSP servers
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - The best autocomplete plugin for Neovim
- [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
- [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ) - Snippet engine
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Preconfigured snippets for multiple languages
- [TrueZen.nvim](https://github.com/Pocco81/TrueZen.nvim) - Distraction-free environment in Neovim
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Used on syntax highlight and custom motions
- [nvim-treesitter-playground](https://github.com/nvim-treesitter/playground) - Treesiter Playground
- [glow.nvim](https://github.com/ellisonleao/glow.nvim) - Terminal Markdown preview
- [go.nvim](https://github.com/ellisonleao/go.nvim) - Go development
- [telescope.nvim](https://github.com/nvim-lua/telescope.nvim) - Find, filter, preview and pick using a nice UI

### Plugin development

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua helpers for general usage
- [babelfish.nvim](https://github.com/mjlbach/babelfish.nvim) - Generate vimdocs from Markdown
- [lua-dev.nvim](https://github.com/folke/lua-dev.nvim) - Lua development plugin

## Screenshots of some features

### Empty buffer default view

![](https://i.postimg.cc/PJkyR7XT/01-start.png)

### LSP Diagnostics

![](https://i.postimg.cc/0jvg4QCk/02-lsp-diagnostics.gif)

### Docs and code completion

![](https://i.postimg.cc/vBF9pFx8/03-docs-completion.gif)

### Snippets

![](https://i.postimg.cc/6qhq3T6q/04-snippets.gif)

![](https://i.postimg.cc/0yP3Djkx/05-snippets.gif)

## File and grep search

![](https://i.postimg.cc/prgm43dY/06-find-filter.gif)
