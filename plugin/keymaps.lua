-- global keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts = { remap = false, silent = true }
local mappings = {
  { "n", "<leader>P", [[<Cmd>edit $HOME/.config/nvim/lua/plugins.lua<CR>]], opts }, -- quick edit plugins file
  { "n", "<leader>U", [[<Cmd>PackerSync<CR>]], opts }, -- Update all current plugins
  { "n", "<leader>R", S, opts }, -- reload all custom modules
  { "n", "<leader>,", [[<Cmd>noh<CR>]], opts }, -- clear search highlight
  { "n", "<leader>d", [[<Cmd>bd<CR>]], opts }, -- close current buffer
  { "n", "<leader>c", [[<Cmd>cclose<CR>]], opts }, -- close quickfix list
  { "n", "<leader>h", [[<Cmd>split<CR>]], opts }, -- create horizontal split
  { "n", "<leader>v", [[<Cmd>vsplit<CR>]], opts }, -- create vertical split
  { "v", "<", [[<gv]], opts }, -- move code forward in visual mode
  { "v", ">", [[>gv]], opts }, -- move code backwards in visual mode
  { "n", "<leader>n", [[<Cmd>cn<CR>]], opts }, -- move to next item in quickfix list
  { "n", "<leader>p", [[<Cmd>cp<CR>]], opts }, -- move to prev item in quickfix list
  { "v", "<leader>cn", require("carbon-now").create_snippet, opts }, -- create carbon.now.sh snippet
  {
    "n",
    "<leader>hg",
    function()
      return vim.cmd("TSHighlightCapturesUnderCursor")
    end,
    opts, -- hightlight color groups under cursor
  },
}

for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end
