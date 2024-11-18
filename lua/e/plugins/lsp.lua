return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    version = false,
    event = "BufReadPre",
    dependencies = {
      { "williamboman/mason.nvim", config = true, cmd = "Mason" },
      "nvim-telescope/telescope.nvim",
      { "williamboman/mason-lspconfig.nvim" },
      "hrsh7th/cmp-nvim-lsp",
      "b0o/SchemaStore.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      -- installing tools
      local tools = {
        "shfmt",
        "shellcheck",
        "yamllint",
      }
      for _, f in pairs(tools) do
        local pkg = require("mason-registry").get_package(f)
        if not pkg:is_installed() then
          pkg:install()
        end
      end

      -- diagnostics
      vim.diagnostic.config({
        -- virtual_text = { spacing = 4 },
        virtual_text = false,
        severity_sort = true,
      })

      -- lspconfig
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

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
                vim.diagnostic.goto_prev({ float = true })
              end,
              opts,
            },
            {
              "n",
              "]d",
              function()
                vim.diagnostic.goto_next({ float = true })
              end,
              opts,
            },
            { "n", "<leader>ca", vim.lsp.buf.code_action, opts },
            { "n", "<leader>gR", tb.lsp_references, opts },
            { "i", "<C-x>", vim.lsp.buf.signature_help, opts },
          }

          for _, map in pairs(mappings) do
            vim.keymap.set(unpack(map))
          end
        end,
      })

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true,
            -- quiet = true,
          })
        end,
      })

      -- lsp config info
      -- TODO: use nui.nvim for better presentation
      vim.api.nvim_create_user_command("LspConfig", function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        P(clients)
      end, { nargs = 0 })

      -- setup servers
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              format = { enable = false },
              hint = { enable = true },
            },
          },
        },
        ruff = {},
        pyright = {
          settings = {
            pyright = {
              -- use ruff-lsp for organizing imports
              disableOrganizeImports = true,
            },
            python = {
              -- use ruff-lsp for analysis
              analysis = { ignore = "*" },
            },
          },
        },
        ts_ls = {},
        bashls = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              schemaStore = {
                -- in favor of schemastore
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        terraformls = {},
        gopls = {},
        dockerls = {},
        rust_analyzer = {},
      }

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
}
