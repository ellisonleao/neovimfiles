-- global keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts = { remap = false, silent = true }
local mappings = {
  { "n", "<leader>P", [[<Cmd>edit $HOME/.config/nvim/lua/plugins.lua<CR>]], opts }, -- quick edit plugins file
  { "n", "<leader>F", vim.lsp.buf.formatting_seq_sync, opts }, -- format shortcut
  { "n", "<leader>U", [[<Cmd>PackerSync<CR>]], opts }, -- Update all current plugins
  { "n", "<leader>R", S, opts }, -- reload all custom modules
  { "n", "<leader>,", [[<Cmd>noh<CR>]], opts }, -- clear search highlight
  { "n", "<leader>d", [[<Cmd>bd<CR>]], opts }, -- close current buffer
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
  { "v", "<leader>cn", [[<Cmd>CarbonNow<CR>]], opts }, -- create carbon.now.sh snippet
  {
    "n",
    "<leader>hg",
    function()
      return vim.cmd("TSHighlightCapturesUnderCursor")
    end,
    opts, -- highlight color groups under cursor
  },
}

for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end
