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
    copilot_node_command = vim.env.HOME .. "/.nvm/versions/node/v20.19.2/bin/node", -- Node.js version must be > 20
    keys = {
      { "<leader>cd", ":Copilot disable<CR>", silent = true },
      { "<leader>ce", ":Copilot enable<CR>", silent = true },
    },
  },
}
