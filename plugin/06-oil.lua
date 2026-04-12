H.pack_add({ "stevearc/oil.nvim" })

require("oil").setup({
  columns = { "icon" },
  keymaps = {
    ["<C-v>"] = "actions.select_split",
  },
  view_options = {
    show_hidden = true,
  },
})

-- Open parent directory in current window
H.set_keymap("n", "-", "<CMD>Oil<CR>")
