-- formatter modules
local function prettier()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

require("formatter").setup({
	logging = false,
	filetype = {
		sh = {
			function()
				return { exe = "shfmt", args = { "-" }, stdin = true }
			end,
		},
		lua = {
			function()
				-- check if current folder has a lua formatter file
				local cfg = vim.fn.findfile("stylua.toml")
				if cfg == "" then
					cfg = vim.fn.expand("~/.config/nvim/lua/stylua.toml")
				end
				return { exe = "stylua", args = { "--config-path=" .. cfg, "-" }, stdin = true }
			end,
		},
		python = {
			function()
				return { exe = "black", args = { "-q", "-" }, stdin = true }
			end,
		},
		javascript = { prettier },
		javascriptreact = { prettier },
		markdown = { prettier },
		json = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "json" },
					stdin = true,
				}
			end,
		},
		yaml = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "yaml" },
					stdin = true,
				}
			end,
		},
		go = {
			function()
				return { exe = "gofmt", stdin = true }
			end,
			function()
				return { exe = "goimports", stdin = true }
			end,
		},
	},
})

-- adding format on save autocmd
vim.cmd([[
augroup FormatAu
    autocmd!
    autocmd BufWritePost *.go,*.jsx,*.js,*.json,*.md,*.py,*.yaml,*.sh,*.lua FormatWrite
augroup END
]])
