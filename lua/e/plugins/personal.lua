return {
  { dir = "~/code/dotenv.nvim", config = true, cmd = { "Dotenv", "DotenvGet" } },
  { dir = "~/code/glow.nvim", config = true, cmd = "Glow" },
  { dir = "~/code/gruvbox.nvim" },
  {
    dir = "~/code/carbon-now.nvim",
    opts = { options = { theme = "nord", font_family = "JetBrains Mono" } },
    keys = {
      { "<leader>cn", [[<Cmd>CarbonNow<CR>]], mode = "v" },
    },
    cmd = "CarbonNow",
  },
}
