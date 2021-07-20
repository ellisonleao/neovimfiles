require("bootstrap") -- plugins configs
require("editor") -- editor configs

-- Global functions

-- general print using inspect
P = function(v)
  print(vim.inspect(v))
  return v
end

-- print table values
PP = function(...)
  local vars = vim.tbl_map(vim.inspect, {...})
  print(unpack(vars))
end

-- helper function for quick reloading a lua module and optionally its subpackages
R = function(name, all_submodules)
  local reload = require("plenary.reload").reload_module
  return reload(name, all_submodules)
end

-- reload all my custom modules
RR = function()
  R("editor")
  R("bootstrap")
  R("plugins", true)
  vim.cmd("PackerCompile")
  print("neovimfiles reloaded")
end
