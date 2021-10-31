-- markdown configs
local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap("n", "<leader>toc", [[<Cmd>0read !gh-md-toc %<CR>]], opts) -- add Table of Contents in md files
vim.api.nvim_set_keymap("n", "<leader>m", [[<Cmd>Glow<CR>]], opts) -- open markdown preview
