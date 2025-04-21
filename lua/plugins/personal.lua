return {
  { "ellisonleao/dotenv.nvim", dev = true, config = true, cmd = { "Dotenv", "DotenvGet" } },
  {
    "ellisonleao/carbon-now.nvim",
    dev = true,
    opts = { options = { theme = "One Light", font_family = "JetBrains Mono", padding_horizontal = "100px" } },
    keys = {
      { "<leader>cn", [[<Cmd>CarbonNow<CR>]], mode = "v" },
    },
    config = true,
    cmd = "CarbonNow",
  },
}
