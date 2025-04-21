return {
  {
    "gruvbox.nvim",
    dev = true,
    priority = 1000,
    config = function(opts)
      vim.cmd.colorscheme("gruvbox")
      require("gruvbox").setup(opts)
    end,
  },
}
