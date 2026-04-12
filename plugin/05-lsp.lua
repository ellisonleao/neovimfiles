H.pack_add({
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "b0o/SchemaStore.nvim",
  "stevearc/conform.nvim",
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
