--@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    -- use pyright for hover capabilities
    client.server_capabilities.hoverProvider = false
  end,
}
