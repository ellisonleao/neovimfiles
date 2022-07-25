local fn = vim.fn
local download = function()
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  local packer_bootstrap
  if fn.isdirectory(install_path) == 0 then
    vim.notify("Installing packer...")
    packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
  end

  print(packer_bootstrap)
  vim.cmd("qa")
end

return function()
  if not pcall(require, "packer") then
    download()
    return true
  end

  return false
end
