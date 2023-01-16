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
  { "n", "<leader>ls", [[<Cmd>LspStart<CR>]], opts }, -- start all lsp servers
  { "n", "<leader>lS", [[<Cmd>LspStop<CR>]], opts }, -- stop all lsp servers
  { "n", "<leader>lr", [[<Cmd>LspRestart<CR>]], opts }, -- restart all lsp servers
  { "n", "<leader>li", [[<Cmd>LspInfo<CR>]], opts }, -- show info about all active lsp servers
  { "v", "<", [[<gv]], opts }, -- move code forward in visual mode
  { "v", ">", [[>gv]], opts }, -- move code backwards in visual mode
  { "n", "<leader>n", [[<Cmd>cn<CR>]], opts }, -- move to next item in quickfix list
  { "n", "<leader>p", [[<Cmd>cp<CR>]], opts }, -- move to prev item in quickfix list
}

for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end
