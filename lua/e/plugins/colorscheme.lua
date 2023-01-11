return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    opts = {
      theme_style = "light",
      dark_float = true,
    },
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },
}
