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

-- reload all my custom modules
RR = function()
  R("cfg.editor")
  R("cfg.bootstrap")
  R("cfg.plugins", true)
  R("snippets", true)
  vim.cmd("PackerCompile")
  print("neovimfiles reloaded")
end

PackerReinstall = function(name)
  if package.loaded["packer"] == nil then
    R("packer")
  end

  local utils = require("packer.plugin_utils")
  local suffix = "/" .. name

  local opt, start = utils.list_installed_plugins()
  for _, group in pairs({ opt, start }) do
    if group ~= nil then
      for dir, _ in pairs(group) do
        if dir:sub(-string.len(suffix)) == suffix then
          vim.ui.input({ prompt = "Reinstall " .. dir .. "? [y/n] " }, function(confirmation)
            if string.lower(confirmation) ~= "y" then
              return
            end
            os.execute("cd " .. dir .. " && git fetch --progress origin && git reset --hard origin")
            vim.cmd("PackerSync")
          end)
        end
      end
    end
  end
end

vim.cmd("command! -nargs=1 PackerReinstall lua PackerReinstall <f-args>")

-- Global configs
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/3.8.2/bin/python")
vim.g["test#strategy"] = "neovim"
vim.g.omni_sql_default_compl_type = "syntax"
