-- install language server if its not available
-- TODO: install node version and lib if not available (do not use mason)
local node_version = "v24.12.0"
local lsp_path = vim.env.HOME .. "/.nvm/versions/node/" .. node_version .. "/bin/copilot-language-server"
return {
  cmd = {
    lsp_path,
    "--stdio",
  },
}
