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
      { "williamboman/mason.nvim", config = true, cmd = "Mason" },
      "nvim-telescope/telescope.nvim",
      { "williamboman/mason-lspconfig.nvim" },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- installing tools
      local tools = {
        "stylua",
        "prettier",
        "black",
        "shfmt",
        "shellcheck",
        "yamllint",
      }
      for _, f in pairs(tools) do
        local pkg = require("mason-registry").get_package(f)
        if not pkg:is_installed(f) then
          pkg:install(f)
        end
      end

      -- diagnostics
      vim.diagnostic.config({
        virtual_text = { spacing = 4 },
        severity_sort = true,
      })

      -- lspconfig
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("e.plugins.lsp.format").on_attach(client, buffer)
          require("e.plugins.lsp.keymaps").on_attach(client, buffer)

          -- highlight code references
          if client.supports_method("textDocument/documentHighlight") then
            local lsp_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
            vim.api.nvim_create_autocmd("CursorHold", {
              group = lsp_highlight,
              buffer = buffer,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = buffer,
              group = lsp_highlight,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- setup servers
      local servers = require("e.plugins.lsp.servers")
      require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
      require("mason-lspconfig").setup_handlers({
        function(server)
          local server_opts = servers[server]
          server_opts.capabilities = capabilities
          require("lspconfig")[server].setup(server_opts)
        end,
      })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    opts = function()
      local nls = require("null-ls")
      local formatting = nls.builtins.formatting
      local diagnostics = nls.builtins.diagnostics
      local actions = nls.builtins.code_actions
      return {
        sources = {
          formatting.prettier.with({
            filetypes = { "json", "markdown", "toml" },
          }),
          formatting.shfmt,
          formatting.stylua.with({
            extra_args = function(_)
              -- using default .stylua.toml file or project's one
              local base_cfg = vim.fn.stdpath("config") .. "/.stylua.toml"
              local cfg = vim.fs.find({ ".stylua.toml", "stylua.toml" }, { upward = true })
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
      }
    end,
  },
}