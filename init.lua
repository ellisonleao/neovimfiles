if require("bootstrap")() then
  return
end

-- plugins configs
require("plugins")

-- Global functions

-- general print using inspect
P = function(v)
  print(vim.inspect(v))
  return v
end

-- print table values
PP = function(...)
  local vars = vim.tbl_map(vim.inspect, { ... })
  print(unpack(vars))
end

-- helper function for quick reloading a lua module and optionally its subpackages
R = function(name, all_submodules)
  local reload = require("plenary.reload").reload_module
  reload(name, all_submodules)
end

-- reload all config
S = function()
  local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(dir, "./lua/", "")
    require("plenary.reload").reload_module(dir)
  end
  print("neovimfiles reloaded")
end
