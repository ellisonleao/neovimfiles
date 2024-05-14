-- lua configs
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true
vim.keymap.set("n", "<leader>S", [[<Cmd>luafile %<CR>]], { remap = false }) -- execute current lua file
