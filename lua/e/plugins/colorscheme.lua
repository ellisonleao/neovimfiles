return {
  {
    dir = "~/code/gruvbox.nvim",
    config = function()
      require("gruvbox").setup()
      -- vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    branch = "0.0.x",
    lazy = false,
    priority = 1000,
    opts = {
      dark_float = true,
      overrides = function()
        return {
          BufferLineBackground = {},
        }
      end,
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require("github-theme").setup(opts)
      vim.cmd.colorscheme("github_light")
    end,
  },
}
