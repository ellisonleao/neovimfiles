local set = vim.opt_local
set.shiftwidth = 2
set.tabstop = 2
set.expandtab = true
set.commentstring = "# %s"

vim.lsp.enable("terraformls")
