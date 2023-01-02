local setup = function()
  -- search module
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
  })

  -- extensions
  require("telescope").load_extension("ui-select")
end

return {
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = setup,
    cmd = "Telescope",
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
