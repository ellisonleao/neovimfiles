local M = {}

function M.on_attach(_, bufnr)
  local tb = require("telescope.builtin")
  local opts = { silent = true, noremap = true, buffer = bufnr }
  local mappings = {
    { "n", "<leader>li", vim.cmd.LspInfo, opts },
    { "n", "<leader>ls", vim.cmd.LspStop, opts },
    { "n", "<leader>lr", vim.cmd.LspRestart, opts },
    { "n", "gD", vim.lsp.buf.declaration, opts },
    { "n", "gd", tb.lsp_definitions, opts },
    { "n", "gr", vim.lsp.buf.rename, opts },
    { "n", "<leader>ca", vim.lsp.buf.code_action, opts },
    { "n", "<leader>gR", tb.lsp_references, opts },
    { "n", "<leader>F", require("e.plugins.lsp.format").format, opts },
    { "i", "<C-x>", vim.lsp.buf.signature_help, opts },
    { "n", "[e", vim.diagnostic.goto_next, opts },
    { "n", "]e", vim.diagnostic.goto_prev, opts },
    { "n", "K", vim.lsp.buf.hover, opts },
  }

  for _, map in pairs(mappings) do
    vim.keymap.set(unpack(map))
  end
end

return M
