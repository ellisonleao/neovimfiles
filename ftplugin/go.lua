-- go configs
local opt = vim.opt
local opts = {noremap = true}
local mappings = {
  {"n", "<leader>ga", [[<Cmd>GoAlternate<CR>]], opts},
  {"n", "<leader>gt", [[<Cmd>GoTestNearest<CR>]], opts},
  {"n", "<leader>gT", [[<Cmd>GoTest<CR>]], opts},
}
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.colorcolumn = "80,120"

for _, map in pairs(mappings) do
  vim.api.nvim_set_keymap(unpack(map))
end
