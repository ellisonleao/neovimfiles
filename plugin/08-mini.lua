H.pack_add({
  "echasnovski/mini.surround",
  "echasnovski/mini.pick",
})

require("mini.surround").setup()
require("mini.pick").setup({
  mappings = {
    toggle_info = "<C-k>",
    toggle_preview = "<C-f>",
  },
})

local keymaps = {
  { "n", "<leader><leader>", ":Pick buffers<CR>" },
  { "n", "<leader>ff", ":Pick files<CR>" },
  { "n", "<leader>lg", ":Pick grep_live<CR>" },
}

H.set_keymaps(keymaps)
