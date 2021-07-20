-- formatter modules
local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    lua = {
      function()
        -- check if current folder has a lua formatter file
        local cfg = vim.fn.findfile(".lua-format")
        if cfg == "" then
          cfg = vim.fn.expand("~/.config/nvim/lua/.lua-format")
        end
        return {exe = "lua-format", args = {"-c " .. cfg}, stdin = true}
      end,
    },
    python = {
      function()
        return {exe = "black", args = {"-q", "-"}, stdin = true}
      end,
    },
    javascript = {prettier},
    javascriptreact = {prettier},
    markdown = {prettier},
    json = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "json"},
          stdin = true,
        }
      end,
    },
    yaml = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "yaml"},
          stdin = true,
        }
      end,
    },
    go = {
      function()
        return {exe = "gofmt", stdin = true}
      end,
      function()
        return {exe = "goimports", stdin = true}
      end,
    },
  },

})

-- adding format on save autocmd
vim.cmd([[
augroup FormatAu
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]])
