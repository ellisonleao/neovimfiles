-- global keymaps
local opts = { remap = false, silent = true }
local mappings = {
  {
    "n",
    "<leader>U",
    function()
      pcall(require("lazy").sync) -- update packer
      pcall(require("nvim-treesitter.install").update({ with_sync = true })) -- update treesitter parsers
    end,
    opts,
  }, -- Update all current plugins
  { "n", "<leader>,", [[<Cmd>noh<CR>]], opts }, -- clear search highlight
  { "n", "<leader>d", [[<Cmd>bd!<CR>]], opts }, -- close current buffer
  { "n", "<leader>c", [[<Cmd>cclose<CR>]], opts }, -- close quickfix list
  { "n", "<leader>h", [[<Cmd>split<CR>]], opts }, -- create horizontal split
  { "n", "<leader>v", [[<Cmd>vsplit<CR>]], opts }, -- create vertical split
  { "v", "<", [[<gv]], opts }, -- move code forward in visual mode
  { "v", ">", [[>gv]], opts }, -- move code backwards in visual mode
  { "n", "<leader>n", [[<Cmd>cn<CR>]], opts }, -- move to next item in quickfix list
  { "n", "<leader>p", [[<Cmd>cp<CR>]], opts }, -- move to prev item in quickfix list
}

for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end
