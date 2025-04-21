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

vim.api.nvim_create_user_command("CheckLinks", function(opts)
  local path = opts.args
  local uv = vim.loop
  local total = 0

  local function extract_urls(text)
    local url_pattern = "(https?://[%w-_%.%?%.:/%+=&]*)"
    local urls = {}

    for url in string.gmatch(text, url_pattern) do
      table.insert(urls, url)
    end

    return urls
  end

  local function get_random_user_agent()
    local user_agents = {
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36",
      "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0",
      "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko",
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
      "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36",
    }

    math.randomseed(os.time())
    return user_agents[math.random(1, #user_agents)]
  end

  local function request(url, buf)
    local cmd = string.format(
      "curl -H 'User-Agent: %s' -skL -o /dev/null -w '%%{http_code} %%{url_effective}' %s",
      get_random_user_agent(),
      url
    )

    vim.fn.jobstart(cmd, {
      on_stdout = function(_, data)
        data = table.concat(data)
        if data ~= "" then
          total = total + 1
          local status, uri = unpack(vim.split(data, " ", {}))
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, { string.format("%s %s", status, uri) })
        end
      end,
    })
  end

  local function read_file(filepath)
    local fd = assert(uv.fs_open(filepath, "r", 438))
    local stat = assert(uv.fs_fstat(fd))
    local data = assert(uv.fs_read(fd, stat.size, 0))
    assert(uv.fs_close(fd))
    return data
  end

  local data = read_file(path)
  local urls = extract_urls(data)

  vim.cmd.vnew()
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].buftype = "nowrite"
  vim.cmd([[
    highlight StatusCodeOK guifg=#31a11d
    highlight StatusCodeError guifg=#a81b0c
    highlight Url guifg=#00ffff
  ]])
  vim.fn.matchadd("StatusCodeOK", "\\(2\\d\\{2}\\)\\s")
  vim.fn.matchadd("StatusCodeError", "\\([0\\|4\\|5]\\d\\{2}\\)\\s")

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Total URLs = " .. #urls })
  vim.schedule(function()
    for _, url in pairs(urls) do
      request(url, buf)
    end
  end)
end, { nargs = 1, complete = "file" })
