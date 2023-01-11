return {
  {
    "akinsho/bufferline.nvim",
    event = "BufAdd",
    priority = 999,
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        separator_style = "slant",
      },
    },
    keys = {
      {
        "<leader>z",
        function()
          require("bufferline").cycle(-1)
        end,
      }, -- move to the previous buffer
      {
        "<leader>q",
        function()
          require("bufferline").cycle(-1)
        end,
      }, -- move to the previous buffer (same option, different key)
      {
        "<leader>x",
        function()
          require("bufferline").cycle(1)
        end,
      }, -- move to the next buffer
      {
        "<leader>w",
        function()
          require("bufferline").cycle(1)
        end,
      }, -- move to the next buffer (same option, different key)
    },
  },
}
