return {
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
    },
    config = true,
  },
}
