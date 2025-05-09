return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = "copilot" },
      inline = { adapter = "copilot" },
      agent = { adapter = "copilot" },
    },
  },
  keys = {
    { "<leader>ccc", ":CodeCompanionChat Toggle<CR>", { "n", "v" }, silent = true },
    { "<leader>cca", ":CodeCompanionActions<CR>", { "n", "v" }, silent = true },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
