-- bootstrap plugin system
require("bootstrap")

-- plugins and local configs
require("plugins")

-- Global functions

-- general print helper
P = vim.pretty_print

-- helper function for quick reloading a lua module and optionally its subpackages
R = function(name, all_submodules)
  local reload = require("plenary.reload").reload_module
  reload(name, all_submodules)
end

-- reload all config
S = function()
  local cfg = vim.fn.stdpath("config")
  local path = string.format("%s/lua/*", cfg)
  ---@diagnostic disable-next-line: param-type-mismatch
  local lua_dirs = vim.fn.glob(path, 0, 1)
  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(dir, cfg .. "/lua/", "")
    R(dir, true)
  end
  vim.cmd.source("$MYVIMRC")
  print("neovimfiles reloaded")
end
