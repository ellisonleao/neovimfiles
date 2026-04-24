---@type Helpers
_G.H = require("helpers")
---@diagnostic disable-next-line: missing-parameter
_G.P = vim.print

-- default vim.g opts
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- default opts
local options = {
  clipboard = "unnamedplus",
  colorcolumn = "120",
  completeopt = { "menu", "menuone", "noselect" },
  cursorline = true,
  expandtab = true,
  foldlevel = 99,
  ignorecase = true,
  listchars = { eol = "↴", tab = "| ", trail = "~", extends = ">", precedes = "<" },
  list = true,
  modeline = true,
  mouse = "a",
  number = true,
  relativenumber = true,
  scrolloff = 12,
  shada = { "!", "'500", "<50", "s10", "h" },
  shiftwidth = 2,
  shortmess = vim.o.shortmess .. "c",
  showmode = false,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  statuscolumn = "%r %l",
  swapfile = false,
  tabstop = 2,
  softtabstop = 2,
  textwidth = 120,
  title = true,
  updatetime = 500,
  wildignorecase = true,
  wildmode = "list:longest",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.filetype.add({
  env = "env",
})

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.5,
      timeout = 4000,
    },
    pager = {
      height = 0.5,
    },
  },
})

-- default commands
vim.api.nvim_create_user_command("PackClean", function()
  local unused = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  if #unused > 0 then
    vim.pack.del(unused)
  end
end, { nargs = 0 })

-- default autocmds

-- remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RememberCursor", { clear = true }),
  pattern = "*",
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
})

-- lsp progress
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or "done" } }, false, {
      id = "lsp." .. ev.data.client_id,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = value.kind ~= "end" and "running" or "success",
      percent = value.percentage,
    })
  end,
})

-- treesitter highlight
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<filetype>" },
  callback = function()
    vim.treesitter.start()
  end,
})

-- handle vim.pack events
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind, data = ev.data.spec.name, ev.data.kind, ev.data.spec.data
    if data then
      if not ev.data.active then
        vim.cmd.packadd(name)
      end

      -- calls install or update function, if any
      local kind_func = vim.tbl_get(data, "data", kind)
      if kind_func then
        kind_func(ev)
      end
    end
  end,
})

-- default keymaps
local keymaps = {
  { "n", "<leader>U", vim.pack.update }, -- Update all current plugins
  { "n", "<leader>cs", [[<Cmd>noh<CR>]] }, -- clear search highlight
  { "n", "<leader>d", [[<Cmd>bd!<CR>]] }, -- close current buffer
  { "n", "<leader>c", [[<Cmd>cclose<CR>]] }, -- close quickfix list
  { "n", "<leader>h", [[<Cmd>split<CR>]] }, -- create horizontal split
  { "n", "<leader>v", [[<Cmd>vsplit<CR>]] }, -- create vertical split
  { "n", "<CR>", "ciw" }, -- Enter on normal mode will remove the current word and enter insert mode
  { "v", "<", [[<gv]] }, -- move code forward in visual mode
  { "v", ">", [[>gv]] }, -- move code backwards in visual mode
  { "n", "<leader>n", [[<Cmd>cn<CR>]] }, -- move to next item in quickfix list
  { "n", "<leader>p", [[<Cmd>cp<CR>]] }, -- move to prev item in quickfix list
  { "n", "<C-d>", "<C-d>zz" },
  { "n", "<C-u>", "<C-u>zz" },
  { "n", "n", "nzzzv" },
  { "n", "N", "Nzzzv" },
  { "n", "<leader>ic", vim.cmd.Inspect },
  { "n", "<leader>R", vim.cmd.restart },
  { "t", "<Esc>", [[<C-\><C-n>]] },
}

H.set_keymaps(keymaps)
