-- lua configs
local set = vim.opt_local
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
set.expandtab = true
vim.keymap.set("n", "<leader>S", [[<Cmd>luafile %<CR>]], { remap = false }) -- execute current lua file
