return {
  {
    "projekt0n/github-nvim-theme",
    tag = "v0.0.7",
    lazy = false,
    priority = 1000,
    opts = {
      theme_style = "light",
      dark_float = true,
      overrides = function()
        return {
          BufferLineBackground = {},
        }
      end,
    },
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },
}
