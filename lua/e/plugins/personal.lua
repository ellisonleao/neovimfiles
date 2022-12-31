return {
  {
    dir = "~/code/dotenv.nvim",
    config = function()
      require("dotenv").setup()
    end,
  },
  {
    dir = "~/code/glow.nvim",
    config = function()
      require("glow").setup()
    end,
    cmd = "Glow"
  },
  { dir = "~/code/gruvbox.nvim" },
  {
    dir = "~/code/carbon-now.nvim",
    config = function()
      require("carbon-now").setup({ options = { theme = "nord", font_family = "JetBrains Mono" } })
    end,
  },
}
