-- editor options
local options = {
  clipboard = "unnamedplus",
  colorcolumn = "120",
  completeopt = { "menu", "menuone", "noselect" },
  expandtab = true,
  foldlevel = 99,
  ignorecase = true,
  listchars = { eol = "↴", tab = "| ", trail = "~", extends = ">", precedes = "<" },
  list = true,
  modeline = true,
  mouse = "a",
  number = true,
  relativenumber = true,
  scrolloff = 12,
  shada = { "!", "'500", "<50", "s10", "h" },
  shortmess = vim.o.shortmess .. "c",
  showmode = false,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  textwidth = 120,
  title = true,
  updatetime = 500,
  wildignorecase = true,
  wildmode = "list:longest",
  statuscolumn = "%r %l",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.python3_host_prog = "python"
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.mapleader = ","
vim.g.maplocalleader = ","