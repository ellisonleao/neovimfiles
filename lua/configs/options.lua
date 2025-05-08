-- editor options
local options = {
  clipboard = "unnamedplus",
  colorcolumn = "120",
  completeopt = { "menu", "menuone", "noselect" },
  cursorline = true,
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
  shiftwidth = 2,
  shortmess = vim.o.shortmess .. "c",
  showmode = false,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  statuscolumn = "%r %l",
  swapfile = false,
  tabstop = 2,
  softtabstop = 2,
  textwidth = 120,
  title = true,
  updatetime = 500,
  wildignorecase = true,
  wildmode = "list:longest",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.filetype.add({
  env = "env",
})
