local lsp_installer = require("nvim-lsp-installer")
local servers = require("nvim-lsp-installer.servers")

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  local opts = { silent = true, noremap = true }
  local mappings = {
    { "n", "gD", [[<Cmd>lua vim.lsp.buf.declaration()<CR>]], opts },
    { "n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts },
    { "n", "gr", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], opts },
    {
      "n",
      "<leader>gR",
      "<cmd>TroubleToggle lsp_references<CR>",
      opts,
    },
    {
      "i",
      "<C-x>",
      [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]],
      opts,
    },
    {
      "n",
      "[e",
      [[<Cmd>lua vim.diagnostic.goto_next()<CR>]],
      opts,
    },
    {
      "n",
      "]e",
      [[<Cmd>lua vim.diagnostic.goto_prev()<CR>]],
      opts,
    },
  }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], opts)

  for _, map in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(bufnr, unpack(map))
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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
  return {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false }
      ),
    },
  }
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
  "terraformls",
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
          vim.fn.expand("~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"),
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
