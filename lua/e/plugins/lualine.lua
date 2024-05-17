local function lsp_clients()
  return require("lsp-progress").progress({
    format = function(messages)
      local active_clients = vim.lsp.get_clients()
      if #messages > 0 then
        return " LSP:" .. table.concat(messages, " ")
      end
      local client_names = {}
      for i, client in ipairs(active_clients) do
        if client and client.name ~= "" then
          table.insert(client_names, "[" .. client.name .. "]")
        end
      end
      return " LSP:" .. table.concat(client_names, " ")
    end,
  })
end

return {
  {
    "linrongbin16/lsp-progress.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lsp-progress").setup()
    end,
  },
  {
    event = "VeryLazy",
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "linrongbin16/lsp-progress.nvim",
    },
    opts = {
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
          lsp_clients,
          "branch",
          { "diff", symbols = { added = " ", modified = "柳 ", removed = " " } },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
          },
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
    },
    config = function(_, opts)
      require("lualine").setup(opts)
      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "LspProgressStatusUpdated",
        group = "lualine_augroup",
        callback = require("lualine").refresh,
      })
    end,
  },
}
