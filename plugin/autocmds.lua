-- global autocmds

-- remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd([[norm! g`"]])
    end
  end,
})
