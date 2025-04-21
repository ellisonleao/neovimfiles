return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    version = false,
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason.nvim", config = true, cmd = "Mason" },
      "nvim-telescope/telescope.nvim",
      "b0o/SchemaStore.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      -- installing linters/lsp/formatters
      local packages = {
        "bash-language-server",
        "dockerfile-language-server",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "ruff",
        "rust-analyzer",
        "shellcheck",
        "shfmt",
        "stylua",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
        "yamllint",
        "zls",
      }

      local registry = require("mason-registry")
      for _, pkg in pairs(packages) do
        if not registry.is_installed(pkg) then
          registry.get_package(pkg):install()
        end
      end

      -- diagnostics
      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        virtual_lines = true,
      })

      -- lsp config
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          if client.name == "ruff" then
            -- disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
          end

          -- add inlay hints
          if client.server_capabilities.inlayHintProvider then
            vim.keymap.set("n", "<leader>th", function()
              ---@diagnostic disable-next-line: missing-parameter
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end)
          end

          -- keymaps
          local tb = require("telescope.builtin")
          local opts = { silent = true, noremap = true, buffer = 0 }
          local mappings = {
            { "n", "<leader>li", vim.cmd.LspInfo, opts },
            { "n", "<leader>ls", vim.cmd.LspStop, opts },
            { "n", "<leader>lr", vim.cmd.LspRestart, opts },
            { "n", "gD", vim.lsp.buf.declaration, opts },
            { "n", "gd", tb.lsp_definitions, opts },
            { "n", "gT", vim.lsp.buf.type_definition, opts },
            { "n", "gr", vim.lsp.buf.rename, opts },
            {
              "n",
              "[d",
              function()
                vim.diagnostic.prev({ float = true })
              end,
              opts,
            },
            {
              "n",
              "]d",
              function()
                vim.diagnostic.next({ float = true })
              end,
              opts,
            },
            { "n", "<leader>ca", vim.lsp.buf.code_action, opts },
            { "n", "<leader>gR", tb.lsp_references, opts },
            { "i", "<C-x>", vim.lsp.buf.signature_help, opts },
          }

          for _, map in pairs(mappings) do
            ---@diagnostic disable-next-line: deprecated
            vim.keymap.set(unpack(map))
          end
        end,
      })

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff" },
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          })
        end,
      })

      -- enable lsp servers
      vim.lsp.enable({
        "dockerls",
        "gopls",
        "jsonls",
        "lua_ls",
        "pyright",
        "ruff",
        "terraformls",
        "ts_ls",
        "yamlls",
        "zls",
      })
    end,
  },
}
