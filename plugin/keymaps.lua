-- global keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts = { noremap = true, silent = true }
local mappings = {
  { "n", "<leader>P", [[<Cmd>edit $HOME/.config/nvim/lua/bootstrap.lua<CR>]], opts }, -- quick edit plugins.lua file
  { "n", "<leader>U", [[<Cmd>PackerSync<CR>]], opts }, -- Update all current plugins
  { "n", "<leader>R", [[<Cmd>lua RR()<CR>]], opts }, -- reload all custom modules
  { "n", "<leader>,", [[<Cmd>noh<CR>]], opts }, -- clear search highlight
  { "n", "<leader>z", [[<Cmd>bp<CR>]], opts }, -- move to the previous buffer
  { "n", "<leader>q", [[<Cmd>bp<CR>]], opts }, -- move to the previous buffer (same option, different key)
  { "n", "<leader>x", [[<Cmd>bn<CR>]], opts }, -- move to the next buffer
  { "n", "<leader>w", [[<Cmd>bn<CR>]], opts }, -- move to the next buffer (same option, different key)
  { "n", "<leader>d", [[<Cmd>bd<CR>]], opts }, -- close current buffer
  { "n", "<leader>c", [[<Cmd>cclose<CR>]], opts }, -- close quickfix list
  { "n", "<leader>h", [[<Cmd>split<CR>]], opts }, -- create horizontal split
  { "n", "<leader>v", [[<Cmd>vsplit<CR>]], opts }, -- create vertical split
  { "v", "<", [[<gv]], opts }, -- move code forward in visual mode
  { "v", ">", [[>gv]], opts }, -- move code backwards in visual mode
  { "n", "<leader>n", [[<Cmd>cn<CR>]], opts }, -- move to next item in quickfix list
  { "n", "<leader>p", [[<Cmd>cp<CR>]], opts }, -- move to prev item in quickfix list
}

for _, map in pairs(mappings) do
  vim.api.nvim_set_keymap(unpack(map))
end
