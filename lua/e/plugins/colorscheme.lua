return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({ theme_style = "light", dark_float = true })
    end,
  },
}
