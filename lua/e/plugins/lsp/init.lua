local servers = require("e.plugins.lsp.servers")

local on_attach = function(client, bufnr)
  require("e.plugins.lsp.format").on_attach(client, bufnr)
  require("e.plugins.lsp.keymaps").on_attach(client, bufnr)

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

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup({
            library = { plugins = { "neotest", "plenary.nvim" }, types = true, setup_jsonls = false },
          })
        end,
      },
      { "mason-org/mason.nvim", config = true, cmd = "Mason" },
      { "nvim-telescope/telescope.nvim" },
      { "mason-org/mason-lspconfig.nvim", config = { automatic_installation = true } },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- installing tools
      local tools = {
        "stylua",
        "prettier",
        "black",
        "shfmt",
        "golangci-lint",
        "shellcheck",
        "yamllint",
      }
      for _, f in pairs(tools) do
        local pkg = require("mason-registry").get_package(f)
        if not pkg:is_installed(f) then
          pkg:install(f)
        end
      end

      -- lspconfig
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      for server, opts in pairs(servers) do
        opts.capabilities = capabilities
        opts.on_attach = on_attach
        require("lspconfig")[server].setup(opts)
      end
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      local nls = require("null-ls")
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
            extra_args = function(_)
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
    end,
  },
}
