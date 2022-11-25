-- module treesiter
require("nvim-treesitter.configs").setup({
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
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
