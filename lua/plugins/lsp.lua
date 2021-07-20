local nvim_lsp = require("lspconfig")
local lspinstall = require("lspinstall")

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  local opts = {silent = true, noremap = true}
  local mappings = {
    {"n", "gD", [[<Cmd>lua require('lspsaga.provider').preview_definition()<CR>]], opts},
    {"n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts},
    {"n", "gr", [[<Cmd>lua require('lspsaga.rename').rename()<CR>]], opts},
    {
      "n",
      "gs",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
    {
      "n",
      "<leader>gR",
      [[<Cmd>lua require("telescope.builtin").lsp_references{ path_display = "absolute" }<CR>]],
      {noremap = true, silent = true},
    },
    {
      "i",
      "<C-x>",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
    {
      "n",
      "[e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>]],
      opts,
    },
    {
      "n",
      "]e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() <CR>]],
      opts,
    },
    {
      "n",
      "]e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() <CR>]],
      opts,
    },
  }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K",
                              [[<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]],
                              opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>",
                              [[<Cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>]],
                              opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-b>",
                              [[<Cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>]],
                              opts)

  for _, map in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(bufnr, unpack(map))
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F",
                                "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F",
                                "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]])
  end
end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport =
    {properties = {"documentation", "detail", "additionalTextEdits"}}
  return {on_attach = on_attach, capabilities = capabilities}
end

local function setup_servers()
  local installed_servers = lspinstall.installed_servers()
  local required_servers = {"lua", "go", "typescript", "python", "bash", "yaml", "vim"}
  for _, svr in pairs(required_servers) do
    if not vim.tbl_contains(installed_servers, svr) then
      lspinstall.install_server(svr)
    end
  end

  lspinstall.setup()
  installed_servers = lspinstall.installed_servers()

  local default_config = make_config()
  for _, server in pairs(installed_servers) do
    if server ~= "lua" then
      nvim_lsp[server].setup(default_config)
    end
  end

  -- special case for lua config
  local luadev = require("lua-dev").setup({
    lspconfig = {
      cmd = {
        vim.fn.expand("~/.local/share/nvim/lspinstall/lua/sumneko-lua-language-server"),
      },
      on_attach = default_config.on_attach,
      capabilities = default_config.capabilities,
    },
  })
  nvim_lsp.lua.setup(luadev)
end

setup_servers()

lspinstall.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end

return {config = make_config}
