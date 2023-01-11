return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    config = function(_, opts)
      local t = require("telescope")
      t.setup(opts)
      t.load_extension("ui-select")
      t.load_extension("fzf")
    end,
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    keys = {
      {
        "<leader>lg",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({ hidden = true })
        end,
      },
      {
        "<leader>H",
        function()
          require("telescope.builtin").help_tags()
        end,
      },
    },
  },
}
