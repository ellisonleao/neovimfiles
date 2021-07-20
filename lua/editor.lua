local opt = vim.opt

local function set_globals()
  vim.g.mapleader = ","
  vim.g.maplocalleader = ","
  vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/3.8.2/bin/python")
  vim.g["test#strategy"] = "floaterm"
  vim.g.floaterm_height = 0.8
  vim.g.floaterm_width = 0.8
end

local function set_ui_options()
  opt.termguicolors = true
  opt.mouse = "a"
  opt.title = true
  opt.titlestring = "%{join(split(getcwd(), '/')[-2:], '/')}"
  opt.number = true
  opt.relativenumber = true
  opt.colorcolumn = "120"

  -- colorscheme configs
  vim.g.tokyonight_style = "night"
  vim.cmd("colorscheme tokyonight")
end

local function set_editor_options()
  local options = {
    autoread = true,
    hidden = true,
    ignorecase = true,
    inccommand = "nosplit",
    incsearch = true,
    laststatus = 2,
    listchars = [[eol:$,tab:>-,trail:~,extends:>,precedes:<]],
    modeline = true,
    shada = [[!,'500,<50,s10,h]],
    showcmd = true,
    showmode = false,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    startofline = false,
    textwidth = 120,
    viminfo = [[!,'300,<50,s10,h]],
    wildignorecase = true,
    wildmenu = true,
    wildmode = "list:longest",
    updatetime = 500,
    autoindent = true,
    smartindent = true,
    shortmess = vim.o.shortmess .. "c",
    scrolloff = 12,
    completeopt = "menu,menuone,noselect",
    clipboard = "unnamedplus",
    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 2,
    swapfile = false,
    expandtab = true,
    foldmethod = "indent",
    foldlevelstart = 99,
  }
  for k, v in pairs(options) do
    opt[k] = v
  end

end

local function set_options()
  set_editor_options()
  set_ui_options()
end

local function set_mappings()
  local opts = {noremap = true, silent = true}
  local mappings = {
    {"n", "<leader>E", [[<Cmd>edit $HOME/.config/nvim/lua/editor.lua<CR>]], opts}, -- quick edit editor.lua file
    {"n", "<leader>P", [[<Cmd>edit $HOME/.config/nvim/lua/bootstrap.lua<CR>]], opts}, -- quick edit plugins.lua file
    {"n", "<leader>U", [[<Cmd>PackerSync<CR>]], opts}, -- Update all current plugins
    {"n", "<leader>R", [[<Cmd>lua RR()<CR>]], opts}, -- reload all custom modules
    {"n", "<leader>,", [[<Cmd>noh<CR>]], opts}, -- clear search highlight
    {"n", "<leader>z", [[<Cmd>bp<CR>]], opts}, -- move to the previous buffer
    {"n", "<leader>q", [[<Cmd>bp<CR>]], opts}, -- move to the previous buffer (same option, different key)
    {"n", "<leader>x", [[<Cmd>bn<CR>]], opts}, -- move to the next buffer
    {"n", "<leader>w", [[<Cmd>bn<CR>]], opts}, -- move to the next buffer (same option, different key)
    {"n", "<leader>d", [[<Cmd>bd<CR>]], opts}, -- close current buffer
    {"n", "<leader>c", [[<Cmd>cclose<CR>]], opts}, -- close quickfix list
    {"n", "<leader>h", [[<Cmd>split<CR>]], opts}, -- create horizontal split
    {"n", "<leader>v", [[<Cmd>vsplit<CR>]], opts}, -- create vertical split
    {"v", "<", [[<gv]], opts}, -- move code forward in visual mode
    {"v", ">", [[>gv]], opts}, -- move code backwards in visual mode
    {"n", "<leader>n", [[<Cmd>cn<CR>]], opts}, -- move to next item in quickfix list
    {"n", "<leader>p", [[<Cmd>cp<CR>]], opts}, -- move to prev item in quickfix list
  }

  for _, map in pairs(mappings) do
    vim.api.nvim_set_keymap(unpack(map))
  end

  -- remember last cursor position
  vim.cmd(
    [[ autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]])
end

set_globals()
set_options()
set_mappings()
