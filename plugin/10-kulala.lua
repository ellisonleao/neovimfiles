H.pack_add({ "mistweaverco/kulala.nvim" })

require("kulala").setup({
  global_keymaps = true,
  global_keymaps_prefix = "<leader>k",
  kulala_keymaps_prefix = "",
})

local keymaps = {
  {
    { "x", "o" },
    "of",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end,
  },
}
