return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    version = false,
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
        "black",
        "autoflake",
        "isort",
        "ruff",
        "prettier",
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
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- format on save
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = buffer,
              callback = function(opts)
                vim.lsp.buf.format({
                  bufnr = opts.buf,
                  timeout_ms = 2000,
                })
              end,
            })
          end

          -- keymaps
          local tb = require("telescope.builtin")
          local opts = { silent = true, noremap = true, buffer = buffer }
          local mappings = {
            { "n", "<leader>li", vim.cmd.LspInfo, opts },
            { "n", "<leader>ls", vim.cmd.LspStop, opts },
            { "n", "<leader>lr", vim.cmd.LspRestart, opts },
            { "n", "gD", vim.lsp.buf.declaration, opts },
            { "n", "gd", tb.lsp_definitions, opts },
            { "n", "gr", vim.lsp.buf.rename, opts },
            { "n", "<leader>ca", vim.lsp.buf.code_action, opts },
            { "n", "<leader>gR", tb.lsp_references, opts },
            { "n", "<leader>F", vim.lsp.buf.format, opts },
            { "i", "<C-x>", vim.lsp.buf.signature_help, opts },
            { "n", "[e", vim.diagnostic.goto_next, opts },
            { "n", "]e", vim.diagnostic.goto_prev, opts },
            { "n", "K", vim.lsp.buf.hover, opts },
          }

          for _, map in pairs(mappings) do
            vim.keymap.set(unpack(map))
          end
        end,
      })

      -- lsp config info
      vim.api.nvim_create_user_command("LspConfig", function()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        local config
        for _, client in ipairs(clients) do
          if client.name ~= "null-ls" then
            config = client.config
          end
        end
        P(config)
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
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
        tsserver = {},
        bashls = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        jsonls = {},
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

  -- formatters, linters
  {
    "nvimtools/none-ls.nvim",
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
          formatting.isort,
          formatting.terraform_fmt,
          formatting.autoflake,
          formatting.gofmt,
          formatting.pg_format,
          diagnostics.yamllint.with({
            extra_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 200}}}" },
          }),
          diagnostics.shellcheck,
          diagnostics.ruff,
          actions.shellcheck,
        },
      }
    end,
  },
}
