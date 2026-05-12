H.pack_add({
  "rafamadriz/friendly-snippets",
  {
    src = "saghen/blink.cmp",
    version = vim.version.range("1.*"),
    data = {
      install = function(ev)
        vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
      end,
    },
  },
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "b0o/SchemaStore.nvim",
  "stevearc/conform.nvim",
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  cmdline = { enabled = false },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      lsp = { score_offset = 1000 },
      lazydev = {
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      snippets = { opts = { friendly_snippets = true } },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

require("mason").setup()

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
  "yaml-language-server",
  "yamllint",
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
})

-- conform
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
  },
})

-- lsp config
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- add inlay hints
    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set("n", "<leader>th", function()
        ---@diagnostic disable-next-line: missing-parameter
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end)
    end
  end,
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
  "bashls",
  "dockerls",
  "gopls",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruff",
  "terraformls",
  "yamlls",
})
