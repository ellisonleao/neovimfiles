local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

local opts = { silent = true, remap = false }
local mappings = {
  {
    "n",
    "<leader>z",
    function()
      bufferline.cycle(-1)
    end,
    opts,
  }, -- move to the previous buffer
  {
    "n",
    "<leader>q",
    function()
      bufferline.cycle(-1)
    end,
    opts,
  }, -- move to the previous buffer (same option, different key)
  {
    "n",
    "<leader>x",
    function()
      bufferline.cycle(1)
    end,
    opts,
  }, -- move to the next buffer
  {
    "n",
    "<leader>w",
    function()
      bufferline.cycle(1)
    end,
    opts,
  }, -- move to the next buffer (same option, different key)
}
for _, map in pairs(mappings) do
  vim.keymap.set(unpack(map))
end

bufferline.setup()
