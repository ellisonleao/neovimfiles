return {
  { dir = "~/code/dotenv.nvim", config = true, cmd = { "Dotenv", "DotenvGet" } },
  { dir = "~/code/glow.nvim", opts = { border = "rounded", width = 120 } },
  {
    dir = "~/code/carbon-now.nvim",
    opts = { options = { theme = "nord", font_family = "JetBrains Mono" } },
    keys = {
      { "<leader>cn", [[<Cmd>CarbonNow<CR>]], mode = "v" },
    },
    cmd = "CarbonNow",
  },
  {
    dir = "~/code/gruvbox.nvim",
    config = function()
      require("gruvbox").setup()
    end,
  },
}
