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
        yaml = true,
      },
      copilot_node_command = "/usr/bin/node",
    },
    keys = { { "<leader>cd", ":Copilot disable<CR>" }, { "<leader>ce", ":Copilot enable<CR>" } },
  },
}
