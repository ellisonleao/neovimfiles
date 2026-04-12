-- lua configs
local set = vim.opt_local
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
set.expandtab = true
vim.keymap.set("n", "<leader>S", [[<Cmd>luafile %<CR>]], { remap = false }) -- execute current lua file

H.pack_add({ "folke/lazydev.nvim" })

require("lazydev").setup({
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
  enabled = function(root_dir)
    return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
  end,
})
