-- search module
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
})

-- create mappings
local opts = { noremap = true }
local mappings = {
  { "n", "<leader>lg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], opts },
  { "n", "<leader>ff", [[<Cmd>lua require("telescope.builtin").find_files({hidden=true})<CR>]], opts },
}

for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end
