local _, lspinstaller = pcall(require, "nvim-lsp-installer")
if lspinstaller == nil then
  return
end

local _, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp == nil then
  return
end

local _, lspconfig = pcall(require, "lspconfig")
if lspconfig == nil then
  return
end

local _, nls = pcall(require, "null-ls")
if nls == nil then
  return
end

local _, tb = pcall(require, "telescope.builtin")
if tb == nil then
  return
end

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
cap.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
cap = cmp_lsp.update_capabilities(cap)

local lsp_servers = {
  "sumneko_lua", -- lua
  "pyright", -- python
  "tsserver", -- js, jsx, tsx
  "bashls", -- bash
  "yamlls", -- yaml
  "jsonls", -- json
  "sqlls", -- sql
  "terraformls", -- terraform
  "gopls", -- golang
  "dockerls", -- dockerfiles
}

-- setup lsp-installer
lspinstaller.setup({
  ensure_installed = lsp_servers,
  ui = {
    icons = {
      server_installed = "",
      server_pending = "",
      server_uninstalled = "",
    },
  },
})

local function on_attach(client, bufnr)
  local opts = { silent = true, noremap = true, buffer = bufnr }
  local mappings = {
    { "n", "gD", vim.lsp.buf.declaration, opts },
    { "n", "gd", tb.lsp_definitions, opts },
    { "n", "gr", vim.lsp.buf.rename, opts },
    { "n", "<leader>ca", vim.lsp.buf.code_action, opts },
    { "n", "<leader>gR", tb.lsp_references, opts },
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
      -- TODO: on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
      callback = vim.lsp.buf.formatting_seq_sync,
    })
  end

  -- highlight code references
  if client.supports_method("textDocument/documentHighlight") then
    local lsp_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = lsp_highlight,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = lsp_highlight,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

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
      extra_args = function(params)
        local cfg = vim.fn.stdpath("config") .. "/.stylua.toml"
        if vim.fn.filereadable(params.root .. "/.stylua.toml") == 1 then
          cfg = params.root .. "/.stylua.toml"
        elseif vim.fn.filereadable(params.root .. "/stylua.toml") == 1 then
          cfg = params.root .. "/stylua.toml"
        end
        return { "--config-path", cfg }
      end,
    }),
    formatting.black,
    formatting.terraform_fmt,
    diagnostics.golangci_lint,
    diagnostics.yamllint.with({
      extra_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 200}}}" },
    }),
    diagnostics.shellcheck,
    actions.shellcheck,
  },
  on_attach = on_attach,
})

-- lua special setup
local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {
      vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server",
    },
    Lua = {
      format = false,
    },
    on_attach = on_attach,
    capabilities = cap,
  },
})

for _, server in pairs(lsp_servers) do
  if server == "sumneko_lua" then
    lspconfig[server].setup(luadev)
  else
    lspconfig[server].setup({ on_attach = on_attach, capabilities = cap })
  end
end

-- better UI for errors
require("lsp_lines").register_lsp_virtual_lines()
