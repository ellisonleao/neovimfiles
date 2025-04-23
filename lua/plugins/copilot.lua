return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      vim.schedule(function()
        vim.cmd.Copilot("disable")
      end)
    end,

    keys = { { "<leader>cd", ":Copilot disable<CR>" }, { "<leader>ce", ":Copilot enable<CR>" } },
  },
}
