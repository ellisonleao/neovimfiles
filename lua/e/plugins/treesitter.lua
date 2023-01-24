return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
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
      context_commentstring = { enable = true, enable_autocmd = false },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]]"] = "@function.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>ps"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>pS"] = "@parameter.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    keys = {
      { "<leader>hg", vim.cmd.TSHighlightCapturesUnderCursor }, -- highlight color groups under cursor
    },
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
}
