H.pack_add({
  { src = "nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  "nvim-treesitter/nvim-treesitter",
})

vim.g.no_plugin_maps = true

H.on_pack_changed("nvim-treesitter", function()
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
  require("nvim-treesitter").install(parsers)
end, "install")

H.on_pack_changed("nvim-treesitter", function()
  vim.cmd.TSUpdate()
end, "update")

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

require("nvim-treesitter").install(parsers)

require("nvim-treesitter-textobjects").setup({
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
})

local keymaps = {
  {
    { "x", "o" },
    "of",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end,
  },
  {
    { "x", "o" },
    "if",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end,
  },
  {
    { "x", "o" },
    "oc",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end,
  },
  {
    "n",
    "ic",
    function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end,
    mode = { "x", "o" },
  },
  -- swap
  {
    "n",
    "sn",
    function()
      require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
    end,
  },
  {
    "n",
    "sp",
    function()
      require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
    end,
  },
  -- move
  {
    { "n", "x", "o" },
    "]]",
    function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "[[",
    function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "]m",
    function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end,
  },
  {
    { "n", "x", "o" },
    "[m",
    function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end,
  },
}

H.set_keymaps(keymaps)
