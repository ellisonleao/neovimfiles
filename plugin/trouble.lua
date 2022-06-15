local ok, trouble = pcall(require, "trouble")
if not ok then
  return
end

trouble.setup()
vim.keymap.set("n", "<leader>tx", "<Cmd>TroubleToggle<CR>", { silent = true, remap = false })
