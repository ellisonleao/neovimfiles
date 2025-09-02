local function create_code_actions(client)
  local source_actions = vim.tbl_filter(function(action)
    return vim.startswith(action, "source.")
  end, client.server_capabilities.codeActionProvider.codeActionKinds)

  ---@diagnostic disable-next-line: missing-fields
  vim.lsp.buf.code_action({ context = { only = source_actions } })
end

local function better_go_to_implementation(client)
  local position_params = vim.lsp.util.make_position_params(0, client.offset_encoding)

  client:exec_cmd({
    command = "_typescript.goToSourceDefinition",
    description = "Go to source definition",
    arguments = { vim.uri_from_bufnr(0), position_params.position },
  }, { bufnr = bufnr }, function(error, result)
    if error ~= nil then
      vim.notify("Error when finding source definition: " .. error.message, vim.log.levels.ERROR)
      return
    end

    if result and #result > 0 then
      local items = vim.lsp.util.locations_to_items(result, client.offset_encoding)
      vim.fn.setqflist(items)
      vim.lsp.util.show_document(result[1], client.offset_encoding)
    end
  end)
end

--@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    -- override code actions with typescript
    vim.keymap.set("n", "gra", function()
      create_code_actions(client)
    end, { silent = true, noremap = true, buffer = bufnr })

    -- override default 'gri' mapping with better go to source implementation
    vim.keymap.set("n", "gri", function()
      better_go_to_implementation(client)
    end, { silent = true, noremap = true, buffer = bufnr })
  end,
}
