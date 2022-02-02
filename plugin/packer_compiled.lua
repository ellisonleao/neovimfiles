-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/ellison/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/ellison/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/ellison/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/ellison/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ellison/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.luasnip\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/TrueZen.nvim",
    url = "https://github.com/Pocco81/TrueZen.nvim"
  },
  ["babelfish.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/babelfish.nvim",
    url = "https://github.com/mjlbach/babelfish.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  fzf = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2D\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\nnumhl\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "/home/ellison/code/glow.nvim"
  },
  ["goldsmith.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/goldsmith.nvim",
    url = "https://github.com/WhoIsSethDaniel/goldsmith.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "/home/ellison/code/gruvbox.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lualine\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  neogit = {
    config = { "\27LJ\1\0028\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\1\2_\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\foptions\1\0\0\1\0\1\fnumbers\tboth\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.cmp\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.lsp\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2A\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vconfig\23plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    config = { "\27LJ\1\0022\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\tocto\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-lua/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\1\2©\1\0\0\5\0\n\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\27<Cmd>TroubleToggle<CR>\15<leader>xx\6n\20nvim_set_keymap\bapi\bvim\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-dotenv"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-dotenv",
    url = "https://github.com/tpope/vim-dotenv"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\1\2ˆ\2\0\0\n\0\t\0\0253\0\0\0002\1\4\0003\2\1\0;\0\4\2;\2\1\0013\2\2\0;\0\4\2;\2\2\0013\2\3\0;\0\4\2;\2\3\0014\2\4\0\16\3\1\0>\2\2\4D\5\a€4\a\5\0007\a\6\a7\a\a\a4\b\b\0\16\t\6\0>\b\2\0=\a\0\1B\5\3\3N\5÷G\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>gs\15<Cmd>G<CR>\1\4\0\0\6n\15<leader>gp\22<Cmd>Git push<CR>\1\4\0\0\6n\15<leader>gc\24<Cmd>Git commit<CR>\1\0\2\vsilent\2\fnoremap\2\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-startify"] = {
    config = { "\27LJ\1\2K\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\2\0\0\23~/.config/nvim/lua\23startify_bookmarks\6g\bvim\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-startify",
    url = "https://github.com/mhinz/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-test"] = {
    config = { "\27LJ\1\2à\1\0\0\n\0\b\0\0223\0\0\0002\1\3\0003\2\1\0;\0\4\2;\2\1\0013\2\2\0;\0\4\2;\2\2\0014\2\3\0\16\3\1\0>\2\2\4D\5\a€4\a\4\0007\a\5\a7\a\6\a4\b\a\0\16\t\6\0>\b\2\0=\a\0\1B\5\3\3N\5÷G\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>tt\22<Cmd>TestFile<CR>\1\4\0\0\6n\14<leader>t\25<Cmd>TestNearest<CR>\1\0\2\vsilent\2\fnoremap\2\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: octo.nvim
time([[Config for octo.nvim]], true)
try_loadstring("\27LJ\1\0022\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\tocto\frequire\0", "config", "octo.nvim")
time([[Config for octo.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\1\2+\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\16plugins.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\1\2A\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vconfig\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-startify
time([[Config for vim-startify]], true)
try_loadstring("\27LJ\1\2K\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\2\0\0\23~/.config/nvim/lua\23startify_bookmarks\6g\bvim\0", "config", "vim-startify")
time([[Config for vim-startify]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\1\2ˆ\2\0\0\n\0\t\0\0253\0\0\0002\1\4\0003\2\1\0;\0\4\2;\2\1\0013\2\2\0;\0\4\2;\2\2\0013\2\3\0;\0\4\2;\2\3\0014\2\4\0\16\3\1\0>\2\2\4D\5\a€4\a\5\0007\a\6\a7\a\a\a4\b\b\0\16\t\6\0>\b\2\0=\a\0\1B\5\3\3N\5÷G\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>gs\15<Cmd>G<CR>\1\4\0\0\6n\15<leader>gp\22<Cmd>Git push<CR>\1\4\0\0\6n\15<leader>gc\24<Cmd>Git commit<CR>\1\0\2\vsilent\2\fnoremap\2\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.luasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: vim-test
time([[Config for vim-test]], true)
try_loadstring("\27LJ\1\2à\1\0\0\n\0\b\0\0223\0\0\0002\1\3\0003\2\1\0;\0\4\2;\2\1\0013\2\2\0;\0\4\2;\2\2\0014\2\3\0\16\3\1\0>\2\2\4D\5\a€4\a\4\0007\a\5\a7\a\6\a4\b\a\0\16\t\6\0>\b\2\0=\a\0\1B\5\3\3N\5÷G\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>tt\22<Cmd>TestFile<CR>\1\4\0\0\6n\14<leader>t\25<Cmd>TestNearest<CR>\1\0\2\vsilent\2\fnoremap\2\0", "config", "vim-test")
time([[Config for vim-test]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\1\2©\1\0\0\5\0\n\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\0014\0\3\0007\0\4\0007\0\5\0%\1\6\0%\2\a\0%\3\b\0003\4\t\0>\0\5\1G\0\1\0\1\0\2\fnoremap\2\vsilent\2\27<Cmd>TroubleToggle<CR>\15<leader>xx\6n\20nvim_set_keymap\bapi\bvim\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\2D\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\1\nnumhl\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\1\0021\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\22plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\1\2_\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\foptions\1\0\0\1\0\1\fnumbers\tboth\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\1\0028\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\1\2/\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\20plugins.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
