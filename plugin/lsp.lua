local ok, _ = pcall(require, "nvim-lsp-installer")
if not ok then
  return
end
local servers = require("nvim-lsp-installer.servers")

local ok, nls = pcall(require, "null-ls")
if not ok then
  return
end

local function on_attach(client, bufnr)
  local opts = { silent = true, noremap = true, buffer = bufnr }
  local mappings = {
    { "n", "gD", vim.lsp.buf.declaration, opts },
    { "n", "gd", vim.lsp.buf.definition, opts },
    { "n", "gr", vim.lsp.buf.rename, opts },
    {
      "n",
      "<leader>gR",
      function()
        require("trouble").toggle("lsp_references")
      end,
      opts,
    },
    { "i", "<C-x>", vim.lsp.buf.signature_help, opts },
    { "n", "[e", vim.diagnostic.goto_next, opts },
    { "n", "]e", vim.diagnostic.goto_prev, opts },
    { "n", "K", vim.lsp.buf.hover, opts },
  }

  for _, map in pairs(mappings) do
    vim.keymap.set(unpack(map))
  end

  -- format on save
  if client.supports_method("textDocument/formatting") then
    local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds({ group = lsp_formatting_group, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = lsp_formatting_group,
      buffer = bufnr,
      callback = function()
        -- TODO: on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.formatting_seq_sync()
      end,
    })
  end

  -- Set autocommands conditional on server_capabilities
  if client.supports_method("textDocument/documentHighlight") then
    local lsp_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = lsp_highlight,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = lsp_highlight,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
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

-- default config
local cfg = make_config()

-- configuring null-ls for formatters
local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local actions = nls.builtins.code_actions

nls.setup({
  sources = {
    formatting.prettier.with({
      filetypes = { "json", "markdown", "toml" },
    }),
    formatting.shfmt,
    formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/.stylua.toml") },
    }),
    formatting.black,
    formatting.terraform_fmt,
    formatting.goimports,
    diagnostics.golangci_lint,
    diagnostics.yamllint.with({
      extra_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 200}}}" },
    }),
    diagnostics.shellcheck,
    actions.shellcheck,
  },
  on_attach = cfg.on_attach,
})

-- lua special setup
local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {
      vim.fn.expand("~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"),
    },
    Lua = {
      format = false,
    },
    on_attach = cfg.on_attach,
    capabilities = cfg.capabilities,
  },
})

-- lsp servers
local required_servers = {
  "sumneko_lua", -- lua
  "pyright", -- python
  "tsserver", -- js, jsx, tsx
  "bashls", -- bash
  "yamlls", -- yaml
  "vimls", -- vim
  "jsonls", -- json
  "sqlls", -- sql
  "terraformls", -- terraform
  "gopls", -- golang
}

-- check for missing lsp servers and install them
for _, svr in pairs(required_servers) do
  local ok, lsp_server = servers.get_server(svr)
  if ok then
    if not lsp_server:is_installed() then
      lsp_server:install()
    end

    lsp_server:on_ready(function()
      if svr == "sumneko_lua" then
        lsp_server:setup(luadev)
      else
        lsp_server:setup(cfg)
      end
    end)
  end
end

return { config = make_config }
