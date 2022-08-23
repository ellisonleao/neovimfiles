local lspinstaller = require("nvim-lsp-installer")
local cmp_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local nls = require("null-ls")
local tb = require("telescope.builtin")
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
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      -- TODO: on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
      callback = vim.lsp.buf.formatting_seq_sync,
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
    formatting.gofmt,
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
  library = { plugins = { "neotest" }, types = true },
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

-- better lsp notifications from notify
vim.api.nvim_create_autocmd({ "UIEnter" }, {
  once = true,
  callback = function()
    local Spinner = require("spinner")
    local spinners = {}

    local function format_msg(msg, percentage)
      msg = msg or ""
      if not percentage then
        return msg
      end
      return string.format("%2d%%\t%s", percentage, msg)
    end

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = { "LspProgressUpdate" },
      group = vim.api.nvim_create_augroup("LSPNotify", { clear = true }),
      desc = "LSP progress notifications",
      callback = function()
        for _, c in ipairs(vim.lsp.get_active_clients()) do
          for token, ctx in pairs(c.messages.progress) do
            if not spinners[c.id] then
              spinners[c.id] = {}
            end
            local s = spinners[c.id][token]
            if not ctx.done then
              if not s then
                spinners[c.id][token] = Spinner(format_msg(ctx.message, ctx.percentage), vim.log.levels.INFO, {
                  title = ctx.title and string.format("%s: %s", c.name, ctx.title) or c.name,
                })
              else
                s:update(format_msg(ctx.message, ctx.percentage))
              end
            else
              c.messages.progress[token] = nil
              if s then
                s:done(ctx.message or "Complete", nil, {
                  icon = "",
                })
                spinners[c.id][token] = nil
              end
            end
          end
        end
      end,
    })
  end,
})
