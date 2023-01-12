return {
  { version = false, dir = "~/code/dotenv.nvim", config = true, cmd = { "Dotenv", "DotenvGet" } },
  { version = false, dir = "~/code/glow.nvim", config = true, cmd = "Glow" },
  { version = false, dir = "~/code/gruvbox.nvim" },
  {
    version = false,
    dir = "~/code/carbon-now.nvim",
    opts = { options = { theme = "nord", font_family = "JetBrains Mono" } },
    keys = {
      { "<leader>cn", [[<Cmd>CarbonNow<CR>]], mode = "v" },
    },
    cmd = "CarbonNow",
  },
}
