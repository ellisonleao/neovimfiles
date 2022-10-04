-- search module
local telescope = require("telescope")
telescope.setup({
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
  {
    "n",
    "<leader>lg",
    function()
      require("telescope.builtin").live_grep()
    end,
    opts,
  },
  {
    "n",
    "<leader>ff",
    function()
      require("telescope.builtin").find_files({ hidden = true })
    end,
    opts,
  },
}

for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end
