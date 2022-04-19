-- lua configs
local opt = vim.opt
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
vim.keymap.set("n", "<leader>S", [[<Cmd>luafile %<CR>]], { remap = false }) -- execute current lua file
