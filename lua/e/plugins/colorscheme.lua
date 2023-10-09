return {
  {
    "ellisonleao/gruvbox.nvim",
    dev = true,
    priority = 1000,
    opts = {},
    config = true,
  },
  { "sainnhe/gruvbox-material" },
  {
    "projekt0n/github-nvim-theme",
    branch = "0.0.x",
    lazy = false,
    priority = 1000,
    opts = {
      dark_float = true,
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require("github-theme").setup(opts)
      vim.cmd.colorscheme("github_light")
    end,
  },
}
