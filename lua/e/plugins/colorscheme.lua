return {
  {
    "~/code/gruvbox.nvim",
    dev = true,
    priority = 1000,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local opts
      local is_night = tonumber(os.date("%H")) >= 18
      if is_night then
        vim.opt.background = "dark"
        opts = { style = "deep" }
      else
        vim.opt.background = "light"
      end

      require("onedark").setup(opts)
      vim.cmd.colorscheme("onedark")
    end,
  },
}
