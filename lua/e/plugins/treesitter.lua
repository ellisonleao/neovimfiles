return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      ensure_installed = {
        "go",
        "gomod",
        "python",
        "lua",
        "yaml",
        "json",
        "javascript",
        "bash",
        "typescript",
        "hcl",
        "make",
        "toml",
        "markdown",
      },
      enable_autocmd = false,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    build = ":TSUpdate",
    event = "BufReadPost",
  },
}
