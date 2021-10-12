-- lua configs
local opt = vim.opt
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
vim.api.nvim_set_keymap("n", "<leader>S", [[<Cmd>luafile %<CR>]], { noremap = true }) -- execute current lua file
