-- global autocmds

-- remember last cursor position
local group = vim.api.nvim_create_augroup("RememberCursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  pattern = "*",
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- live preview
vim.api.nvim_create_user_command("Preview", function()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("TextChangedI", {
    group = vim.api.nvim_create_augroup("GlowChanged", { clear = true }),
    buffer = buf,
    callback = function()
      -- get file contents
      -- XXX: must find another to get the old buffer
      local buffers = vim.api.nvim_list_bufs()
      local preview_buffer
      for _, b in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(b) and b ~= buf then
          preview_buffer = b
          break
        end
      end

      if preview_buffer == nil then
        print("cur buf not found")
        return
      end

      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local chan = vim.api.nvim_open_term(preview_buffer, {})
      local text = table.concat(lines)
      local cmd = string.format("echo '%s' | glow -", text)
      vim.fn.jobstart(cmd, {
        on_stderr = function(_, data)
          local d = table.concat(data)
          if d ~= "" then
            P("error", data)
          end
        end,
        on_stdout = function(_, data)
          vim.api.nvim_chan_send(chan, table.concat(data) .. "\r\n")
        end,
      })
    end,
  })

  vim.cmd("vnew")
  vim.cmd("wincmd w")
end, { nargs = 0 })
