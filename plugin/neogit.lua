require("neogit").setup({
  kind = "split",
  integrations = { diffview = true },
  disable_commit_confirmation = true,
})

local opts = { noremap = true, silent = true }
local mappings = {
  { "n", "<leader>gc", [[<Cmd>Neogit commit<CR>]], opts },
  { "n", "<leader>gp", [[<Cmd>Neogit push<CR>]], opts },
  { "n", "<leader>gs", [[<Cmd>Neogit<CR>]], opts },
}

for _, m in pairs(mappings) do
  vim.keymap.set(unpack(m))
end
