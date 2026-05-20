H.pack_add({ "nvim-treesitter/nvim-treesitter", "mistweaverco/kulala.nvim" })

require("kulala").setup({
  global_keymaps = true,
  global_keymaps_prefix = "<leader>k",
  kulala_keymaps_prefix = "",
})
