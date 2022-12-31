-- editor options
local options = {
  background = "light",
  mouse = "a",
  number = true,
  relativenumber = true,
  colorcolumn = "120",
  title = true,
  ignorecase = true,
  list = true,
  listchars = { eol = "↴", tab = "| ", trail = "~", extends = ">", precedes = "<" },
  modeline = true,
  shada = { "!", "'500", "<50", "s10", "h" },
  showmode = false,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  textwidth = 120,
  wildignorecase = true,
  wildmode = "list:longest",
  updatetime = 500,
  smartindent = true,
  shortmess = vim.o.shortmess .. "c",
  scrolloff = 12,
  completeopt = { "menu", "menuone", "noselect" },
  clipboard = "unnamedplus",
  shiftwidth = 4,
  softtabstop = 4,
  tabstop = 4,
  swapfile = false,
  expandtab = true,
  foldlevel = 99,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.python3_host_prog = "python"
vim.g["test#strategy"] = "neovim"
vim.g.omni_sql_default_compl_type = "syntax"
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.mapleader = ","
vim.g.maplocalleader = ","
