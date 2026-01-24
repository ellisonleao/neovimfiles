return {
  "mistweaverco/kulala.nvim",
  keys = {
    {
      "<leader>kr",
      function()
        require("kulala").run()
      end,
      mode = { "n", "v" },
    },
    {
      "<leader>ka",
      function()
        require("kulala").run_all()
      end,
      mode = { "n", "v" },
    },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = false,
    lsp = { formatter = true },
  },
}
