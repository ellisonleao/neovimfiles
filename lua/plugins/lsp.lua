local lsp_installer = require("nvim-lsp-installer")
local servers = require("nvim-lsp-installer.servers")

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  local opts = { silent = true, noremap = true }
  local mappings = {
    { "n", "gD", [[<Cmd>lua require('lspsaga.provider').preview_definition()<CR>]], opts },
    { "n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts },
    { "n", "gr", [[<Cmd>lua require('lspsaga.rename').rename()<CR>]], opts },
    {
      "n",
      "gs",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
    {
      "n",
      "<leader>gR",
      [[<Cmd>lua require("telescope.builtin").lsp_references{ path_display = "absolute" }<CR>]],
      { noremap = true, silent = true },
    },
    {
      "i",
      "<C-x>",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
    {
      "n",
      "[e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>]],
      opts,
    },
    {
      "n",
      "]e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() <CR>]],
      opts,
    },
    {
      "n",
      "]e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() <CR>]],
      opts,
    },
  }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", [[<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<C-f>",
    [[<Cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>]],
    opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<C-b>",
    [[<Cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>]],
    opts
  )

  for _, map in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(bufnr, unpack(map))
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]])
  end
end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  return { on_attach = on_attach, capabilities = capabilities }
end

-- lsp servers
local required_servers = {
  "gopls", -- golang
  "sumneko_lua", -- lua
  "pyright", -- python
  "tsserver", -- js, jsx, tsx
  "bashls", -- bash
  "yamlls", -- yaml
  "vimls", -- vim
  "jsonls", -- json
  "sqlls", -- sql
}

-- check for missing lsp servers and install them
for _, svr in pairs(required_servers) do
  local ok, lsp_server = servers.get_server(svr)
  if ok then
    if not lsp_server:is_installed() then
      lsp_server:install()
    end
  end
end

local cfg = make_config()

lsp_installer.on_server_ready(function(server)
  if server.name == "sumneko_lua" then
    local luadev = require("lua-dev").setup({
      lspconfig = {
        cmd = {
          vim.fn.expand("~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/Linux/lua-language-server"),
        },
        on_attach = cfg.on_attach,
        capabilities = cfg.capabilities,
      },
    })
    server:setup(luadev)
  else
    server:setup(cfg)
  end
  vim.cmd([[do User LspAttachBuffers]])
end)

return { config = make_config }
