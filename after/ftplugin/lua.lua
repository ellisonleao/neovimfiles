-- lua configs
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.keymap.set("n", "<leader>S", [[<Cmd>luafile %<CR>]], { remap = false }) -- execute current lua file
