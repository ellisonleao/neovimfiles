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
local package_path_str = "/home/ellison/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/ellison/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/ellison/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/ellison/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ellison/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
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
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["babelfish.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/babelfish.nvim"
  },
  ["formatter.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.formatter\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\nnumhl\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  ["go.nvim"] = {
    config = { "\27LJ\2\n`\0\0\6\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0006\3\0\0'\5\3\0B\3\2\0029\3\2\3B\3\1\2=\3\5\2B\0\2\1K\0\1\0\blsp\1\0\0\16plugins.lsp\vconfig\ago\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/opt/go.nvim"
  },
  kommentary = {
    config = { "\27LJ\2\n|\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.lspsaga\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\4\0\0\a\0\29\0-6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0034\4\3\0005\5\v\0>\5\1\0045\5\f\0005\6\r\0=\6\14\5>\5\2\4=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\3=\3\22\0025\3\23\0004\4\0\0=\4\b\0034\4\0\0=\4\n\0035\4\24\0=\4\15\0035\4\25\0=\4\17\0034\4\0\0=\4\19\0034\4\0\0=\4\21\3=\3\26\0025\3\27\0=\3\28\2B\0\2\1K\0\1\0\15extensions\1\3\0\0\rfugitive\rquickfix\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\1\2\1\0\rfilename\tpath\3\2\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n_\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\fnumbers\tboth\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    after_files = { "/home/ellison/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18plugins.compe\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23plugins.treesitter\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["orgmode.nvim"] = {
    config = { "\27LJ\2\nž\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\27org_default_notes_file\1\2\0\0\25~/.orgmode/notes.org\21org_agenda_files\1\0\0\1\2\0\0\17~/.orgmode/*\nsetup\forgmode\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\nˆ\2\0\0\f\0\t\0\0255\0\0\0004\1\4\0005\2\1\0>\0\4\2>\2\1\0015\2\2\0>\0\4\2>\2\2\0015\2\3\0>\0\4\2>\2\3\0016\2\4\0\18\4\1\0B\2\2\4H\5\a€6\a\5\0009\a\6\a9\a\a\a6\t\b\0\18\v\6\0B\t\2\0A\a\0\1F\5\3\3R\5÷K\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>gs\15<Cmd>G<CR>\1\4\0\0\6n\15<leader>gp\22<Cmd>Git push<CR>\1\4\0\0\6n\15<leader>gc\24<Cmd>Git commit<CR>\1\0\2\fnoremap\2\vsilent\2\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-startify"] = {
    config = { "\27LJ\2\nK\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\23~/.config/nvim/lua\23startify_bookmarks\6g\bvim\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    config = { "\27LJ\2\nà\1\0\0\f\0\b\0\0225\0\0\0004\1\3\0005\2\1\0>\0\4\2>\2\1\0015\2\2\0>\0\4\2>\2\2\0016\2\3\0\18\4\1\0B\2\2\4H\5\a€6\a\4\0009\a\5\a9\a\6\a6\t\a\0\18\v\6\0B\t\2\0A\a\0\1F\5\3\3R\5÷K\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>tT\22<Cmd>TestFile<CR>\1\4\0\0\6n\14<leader>t\25<Cmd>TestNearest<CR>\1\0\2\fnoremap\2\vsilent\2\0" },
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/ellison/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\nˆ\2\0\0\f\0\t\0\0255\0\0\0004\1\4\0005\2\1\0>\0\4\2>\2\1\0015\2\2\0>\0\4\2>\2\2\0015\2\3\0>\0\4\2>\2\3\0016\2\4\0\18\4\1\0B\2\2\4H\5\a€6\a\5\0009\a\6\a9\a\a\a6\t\b\0\18\v\6\0B\t\2\0A\a\0\1F\5\3\3R\5÷K\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>gs\15<Cmd>G<CR>\1\4\0\0\6n\15<leader>gp\22<Cmd>Git push<CR>\1\4\0\0\6n\15<leader>gc\24<Cmd>Git commit<CR>\1\0\2\fnoremap\2\vsilent\2\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: orgmode.nvim
time([[Config for orgmode.nvim]], true)
try_loadstring("\27LJ\2\nž\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\27org_default_notes_file\1\2\0\0\25~/.orgmode/notes.org\21org_agenda_files\1\0\0\1\2\0\0\17~/.orgmode/*\nsetup\forgmode\frequire\0", "config", "orgmode.nvim")
time([[Config for orgmode.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23plugins.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.lspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: vim-startify
time([[Config for vim-startify]], true)
try_loadstring("\27LJ\2\nK\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\2\0\0\23~/.config/nvim/lua\23startify_bookmarks\6g\bvim\0", "config", "vim-startify")
time([[Config for vim-startify]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.formatter\frequire\0", "config", "formatter.nvim")
time([[Config for formatter.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16plugins.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\nnumhl\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n\4\0\0\a\0\29\0-6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0034\4\3\0005\5\v\0>\5\1\0045\5\f\0005\6\r\0=\6\14\5>\5\2\4=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\3=\3\22\0025\3\23\0004\4\0\0=\4\b\0034\4\0\0=\4\n\0035\4\24\0=\4\15\0035\4\25\0=\4\17\0034\4\0\0=\4\19\0034\4\0\0=\4\21\3=\3\26\0025\3\27\0=\3\28\2B\0\2\1K\0\1\0\15extensions\1\3\0\0\rfugitive\rquickfix\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\fsources\1\2\0\0\rnvim_lsp\1\2\0\0\16diagnostics\1\2\1\0\rfilename\tpath\3\2\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: vim-test
time([[Config for vim-test]], true)
try_loadstring("\27LJ\2\nà\1\0\0\f\0\b\0\0225\0\0\0004\1\3\0005\2\1\0>\0\4\2>\2\1\0015\2\2\0>\0\4\2>\2\2\0016\2\3\0\18\4\1\0B\2\2\4H\5\a€6\a\4\0009\a\5\a9\a\6\a6\t\a\0\18\v\6\0B\t\2\0A\a\0\1F\5\3\3R\5÷K\0\1\0\vunpack\20nvim_set_keymap\bapi\bvim\npairs\1\4\0\0\6n\15<leader>tT\22<Cmd>TestFile<CR>\1\4\0\0\6n\14<leader>t\25<Cmd>TestNearest<CR>\1\0\2\fnoremap\2\vsilent\2\0", "config", "vim-test")
time([[Config for vim-test]], false)
-- Config for: kommentary
time([[Config for kommentary]], true)
try_loadstring("\27LJ\2\n|\0\0\4\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0005\3\4\0B\0\3\1K\0\1\0\1\0\1 prefer_single_line_comments\2\fdefault\23configure_language\22kommentary.config\frequire\0", "config", "kommentary")
time([[Config for kommentary]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\n_\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\fnumbers\tboth\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'go.nvim'}, { ft = "go" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-compe'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
