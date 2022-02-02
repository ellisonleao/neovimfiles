local luasnip = require("luasnip")

function _G.snippets_clear()
  for m, _ in pairs(luasnip.snippets) do
    package.loaded["snippets." .. m] = nil
  end
  luasnip.snippets = setmetatable({}, {
    __index = function(t, k)
      local ok, m = pcall(require, "snippets." .. k)
      if not ok and not string.match(m, "^module.*not found:") then
        error(m)
      end
      t[k] = ok and m or {}
      return t[k]
    end,
  })
end

_G.snippets_clear()

vim.cmd([[
augroup snippets_clear
au!
au BufWritePost ~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
augroup END
]])

function _G.edit_ft()
  -- returns table like {"lua", "all"}
  local fts = require("luasnip.util.util").get_snippet_filetypes()
  vim.ui.select(fts, {
    prompt = "Select which filetype to edit:",
  }, function(item, idx)
    -- selection aborted -> idx == nil
    if idx then
      vim.cmd("edit ~/.config/nvim/lua/snippets/" .. item .. ".lua")
    end
  end)
end

vim.cmd([[command! SnipEdit :lua _G.edit_ft()]])
