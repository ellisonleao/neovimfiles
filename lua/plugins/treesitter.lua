-- module treesiter
local M = {}

function M.config()
	require("nvim-treesitter.configs").setup({
		highlight = { enable = true },
		ensure_installed = {
			"go",
			"python",
			"lua",
			"yaml",
			"json",
			"javascript",
			"bash",
			"typescript",
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
end

return M
