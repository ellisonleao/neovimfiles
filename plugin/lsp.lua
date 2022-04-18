local servers = require("nvim-lsp-installer.servers")
local null_ls = require("null-ls")

local function on_attach(client, bufnr)
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

  -- format on save
  if client.resolved_capabilities.document_formatting then
    local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "<buffer>",
      group = lsp_formatting_group,
      callback = function()
        vim.lsp.buf.formatting_seq_sync()
      end,
    })
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    local lsp_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "<buffer>",
      group = lsp_highlight,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "<buffer>",
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
}

-- default config
local cfg = make_config()

-- configuring null-ls for formatters
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.prettier.with({
      filetypes = { "html", "json", "markdown", "toml" },
    }),
    formatting.shfmt,
    formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
    }),
    formatting.black,
    formatting.terraform_fmt,
    formatting.goimports,
    diagnostics.golangci_lint,
    diagnostics.yamllint,
    diagnostics.shellcheck,
    actions.shellcheck,
  },
  on_attach = cfg.on_attach,
})

-- golang
require("goldsmith").config({
  null = { run_setup = false, revive = false, gofumpt = true, golines = false },
  mappings = { format = {} },
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

-- check for missing lsp servers and install them
for _, svr in pairs(required_servers) do
  local ok, lsp_server = servers.get_server(svr)
  if ok then
    if not require("goldsmith").needed(svr) then
      lsp_server:on_ready(function()
        if svr == "sumneko_lua" then
          lsp_server:setup(luadev)
        else
          lsp_server:setup(cfg)
        end
      end)

      if not lsp_server:is_installed() then
        lsp_server:install()
      end
    end
  end
end

return { config = make_config }
