-- module treesiter
local ok, _ = pcall(require, "nvim-treesitter")
if not ok then
  return
end

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
  },
})

-- custom md
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-markdown",
    files = { "src/parser.c", "src/scanner.cc" },
  },
}
parser_config.toml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-toml",
    files = { "src/parser.c", "src/scanner.c" },
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
