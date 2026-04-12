local M = {}

M.set_keymap = function(mode, shortcut, cmd)
  vim.keymap.set(mode, shortcut, cmd, { remap = false, silent = true })
end

M.set_keymaps = function(keymaps)
  for _, keymap in ipairs(keymaps) do
    local mode, shortcut, cmd = unpack(keymap)
    M.set_keymap(mode, shortcut, cmd)
  end
end

M.pack_add = function(plugins)
  for idx, val in ipairs(plugins) do
    if type(val) == "string" then
      plugins[idx] = "https://github.com/" .. val
    end

    if type(val) == "table" then
      plugins[idx].src = "https://github.com/" .. val.src
      plugins[idx].version = val.version or "main"
    end
  end
  vim.pack.add(plugins)
end

M.on_pack_changed = function(name, cb, kind)
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      if ev.data.spec.name == name and ev.data.kind == kind then
        if not ev.data.active then
          vim.cmd.packadd(name)
        end
        cb(ev)
      end
    end,
  })
end

M.get_root = function()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  path = path and vim.fs.dirname(path) or vim.uv.cwd()
  local root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
  root = root and vim.fs.dirname(root) or vim.uv.cwd()
  return root
end

return M
