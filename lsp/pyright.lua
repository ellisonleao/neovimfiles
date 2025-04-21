return {
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
}
