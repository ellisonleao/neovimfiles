local mlspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_registry = require("mason-registry")
local cmp_lsp = require("cmp_nvim_lsp")
local nls = require("null-ls")
local tb = require("telescope.builtin")
local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
cap.textDocument.completion.completionItem.labelDetailsSupport = true
cap.textDocument.completion.contextSupport = true
cap.textDocument.completion.resolveSupport = {
  properties = { "edit", "documentation", "detail" },
}
cap = cmp_lsp.update_capabilities(cap)

local lsp_servers = {
  "sumneko_lua", -- lua
  "pyright", -- python
  "tsserver", -- js, jsx, tsx
  "bashls", -- bash
  "yamlls", -- yaml
  "jsonls", -- json
  "sqls", -- sql
  "terraformls", -- terraform
  "gopls", -- golang
  "dockerls", -- dockerfiles
}

local tools = {
  "stylua",
  "prettier",
  "black",
  "shfmt",
  "golangci-lint",
  "shellcheck",
  "yamllint",
}

mason.setup({
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
})

-- install tools
for _, f in pairs(tools) do
  local pkg = mason_registry.get_package(f)
  if not pkg:is_installed(f) then
    pkg:install(f)
  end
end

local function on_attach(client, bufnr)
  local opts = { silent = true, noremap = true, buffer = bufnr }
  local mappings = {
    { "n", "gD", vim.lsp.buf.declaration, opts },
    { "n", "gd", tb.lsp_definitions, opts },
    { "n", "gr", vim.lsp.buf.rename, opts },
    { "n", "<leader>ca", vim.lsp.buf.code_action, opts },
    { "n", "<leader>gR", tb.lsp_references, opts },
    { "n", "<leader>lf", vim.lsp.buf.format, opts },
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
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- highlight code references
  if client.supports_method("textDocument/documentHighlight") then
    local lsp_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
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

-- lua special setup
local luadev = require("lua-dev").setup({
  library = { plugins = { "neotest" }, types = true },
  lspconfig = {
    cmd = {
      vim.fn.stdpath("data") .. "/mason/bin/lua-language-server",
    },
    Lua = {
      format = false,
    },
    on_attach = on_attach,
    capabilities = cap,
  },
})

mlspconfig.setup({ ensure_installed = lsp_servers })
mlspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({ on_attach = on_attach, capabilities = cap })
  end,
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup(luadev)
  end,
})

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
        local base_cfg = vim.fn.stdpath("config") .. "/.stylua.toml"
        local cfg = vim.fs.find(".stylua.toml", { upward = true })
        if #cfg == 0 then
          ---@diagnostic disable-next-line: cast-local-type
          cfg = base_cfg
        else
          cfg = cfg[1]
        end
        return { "--config-path", cfg }
      end,
    }),
    formatting.black,
    formatting.terraform_fmt,
    formatting.gofmt,
    formatting.pg_format,
    diagnostics.yamllint.with({
      extra_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 200}}}" },
    }),
    diagnostics.shellcheck,
    actions.shellcheck,
  },
  on_attach = on_attach,
})
