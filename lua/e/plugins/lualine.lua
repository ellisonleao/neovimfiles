local setup = function()
  local lualine = require("lualine")

  -- Lsp server name .
  local function lsp()
    return {
      function()
        local msg = "No Active Lsp"
        local ft = vim.bo.filetype
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end

        local clients_output = {}
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
            table.insert(clients_output, client.name)
          end
        end

        if #clients_output > 0 then
          return table.concat(clients_output, "/")
        else
          return msg
        end
      end,
      icon = "LSP:",
      color = { gui = "bold" },
    }
  end

  -- Config
  local config = {
    options = {
      theme = "auto",
      globalstatus = true,
    },
    winbar = {
      lualine_c = { { "filename", path = 2 } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        lsp(),
        "branch",
        { "diff", symbols = { added = " ", modified = "柳 ", removed = " " } },
        { "diagnostics", sources = { "nvim_diagnostic" }, symbols = { error = " ", warn = " ", info = " " } },
      },
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_v = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }
  lualine.setup(config)
end

return {
  {
    event = "VeryLazy",
    "nvim-lualine/lualine.nvim",
    config = setup,
  },
}
