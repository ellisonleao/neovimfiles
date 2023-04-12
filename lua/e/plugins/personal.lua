return {
  { dir = "~/code/dotenv.nvim", config = true, cmd = { "Dotenv", "DotenvGet" } },
  { dir = "~/code/glow.nvim", opts = { border = "rounded", width = 120 }, cmd = "Glow" },
  {
    dir = "~/code/carbon-now.nvim",
    opts = { options = { theme = "One Light", font_family = "JetBrains Mono" } },
    keys = {
      { "<leader>cn", [[<Cmd>CarbonNow<CR>]], mode = "v" },
    },
    cmd = "CarbonNow",
  },
}