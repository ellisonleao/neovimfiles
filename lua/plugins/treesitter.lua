local parsers = {
  "bash",
  "go",
  "gomod",
  "hcl",
  "html",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "python",
  "regex",
  "toml",
  "typescript",
  "yaml",
  "zig",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {},
      enable_autocmd = false,
    },
    config = function(_, opts)
      -- TODO: automate npm i -g tree-sitter-cli
      require("nvim-treesitter").install(parsers)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "<filetype>" },
        callback = function()
          vim.treesitter.start()
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = false,
      },
      move = { set_jumps = true },
    },
    keys = {
      -- select
      {
        "of",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        mode = { "x", "o" },
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        mode = { "x", "o" },
      },
      {
        "oc",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        mode = { "x", "o" },
      },
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        mode = { "x", "o" },
      },
      -- swap
      {
        "sn",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
      },
      {
        "sp",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
        end,
      },
      -- move
      {
        "]]",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "[[",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "]m",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
      },
      {
        "[m",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
      },
    },
  },
}
