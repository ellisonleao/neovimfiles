-- editor options
local options = {
  background = "light",
  mouse = "a",
  titlestring = "%{join(split(getcwd(), '/')[-2:], '/')}",
  number = true,
  relativenumber = true,
  colorcolumn = "120",
  title = true,
  autoread = true,
  hidden = true,
  ignorecase = true,
  inccommand = "nosplit",
  incsearch = true,
  laststatus = 2,
  list = true,
  listchars = { eol = "↴", tab = "| ", trail = "~", extends = ">", precedes = "<" },
  modeline = true,
  shada = { "!", "'500", "<50", "s10", "h" },
  showcmd = true,
  showmode = false,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  startofline = false,
  textwidth = 120,
  wildignorecase = true,
  wildmode = "list:longest",
  wildmenu = true,
  updatetime = 500,
  autoindent = true,
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
  foldmethod = "indent",
  foldlevelstart = 99,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.python3_host_prog = "python"
vim.g["test#strategy"] = "neovim"
vim.g.omni_sql_default_compl_type = "syntax"
