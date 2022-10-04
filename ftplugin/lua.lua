-- lua configs
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.keymap.set("n", "<leader>S", [[<Cmd>luafile %<CR>]], { remap = false }) -- execute current lua file
