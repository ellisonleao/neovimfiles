---@class Helpers
local M = {}

---Set a single keymap
---@param mode string|table Mode for the keymap (e.g., "n", "i", "v", or {"n", "x"})
---@param shortcut string The keybinding
---@param cmd string|function The command or function to execute
function M.set_keymap(mode, shortcut, cmd)
  vim.keymap.set(mode, shortcut, cmd, { remap = false, silent = true })
end

---Set multiple keymaps from a table
---@param keymaps table[] Array of keymap definitions [mode, shortcut, cmd]
function M.set_keymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    local mode, shortcut, cmd = unpack(keymap)
    M.set_keymap(mode, shortcut, cmd)
  end
end

---Add plugins from github to the pack
---@param plugins string[]|vim.pack.Spec[]
function M.pack_add(plugins)
  for idx, val in ipairs(plugins) do
    if type(val) == "string" then
      plugins[idx] = "https://github.com/" .. val
    end

    if type(val) == "table" then
      plugins[idx].src = "https://github.com/" .. val.src
      plugins[idx].version = val.version or "main"
      plugins[idx].data = val.data or {}
    end
  end
  vim.pack.add(plugins)
end

---Get the git root directory of the current buffer
---@return string|nil The root directory path
function M.get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  path = path and vim.fs.dirname(path) or vim.uv.cwd()
  local root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
  root = root and vim.fs.dirname(root) or vim.uv.cwd()
  return root
end

return M
