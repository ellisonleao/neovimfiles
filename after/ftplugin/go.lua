-- go configs
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4
vim.opt_local.colorcolumn = "80,120"
vim.opt_local.expandtab = false

local Job = require("plenary.job")
local ns = vim.api.nvim_create_namespace("go")

-- parse go coverage line
local function get_cover_data(line)
  local groups = "([^:]+):(%d+).(%d+),(%d+).(%d+)%s(%d+)%s(%d+)"
  local _, _, file, line0, col0, line1, col1, _, ok = string.find(line, groups)
  local res = {
    file = file,
    line0 = tonumber(line0),
    col0 = tonumber(col0),
    line1 = tonumber(line1),
    col1 = tonumber(col1),
    ok = ok,
  }
  return res
end

-- grab cover file contents and parse it
local function parse_cover(file)
  local lines = {}
  for line in io.lines(file) do
    if line ~= "mode: set" then
      table.insert(lines, get_cover_data(line))
    end
  end
  return lines
end

-- alternate test files and back
local function alternate_test()
  local afile
  local file = vim.fn.expand("%")
  if file == "" then
    print("buffer is empty or file is not a go file")
    return
  elseif vim.endswith(file, "_test.go") then
    local root, _ = string.gsub(file, "_test.go", "")
    afile = string.format("%s.go", root)
  else
    local root = vim.fn.expand("%:p:r")
    afile = string.format("%s_test.go", root)
  end

  if vim.fn.filereadable(afile) == 0 then
    vim.api.nvim_err_writeln("alternate file not found")
    return
  end
  vim.cmd("edit " .. afile)
end

local function clear_coverage()
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

local function coverage()
  local pkg = vim.fn.expand("%:h")
  local tmpfile = vim.fn.tempname()
  local args = { "test", "-cover", "-coverprofile=" .. tmpfile, "./" .. pkg }

  Job:new({
    command = "go",
    args = args,
    on_stderr = vim.schedule_wrap(function(error, _)
      if error ~= nil then
        vim.notify("error on creating coverprofile", vim.log.levels.ERROR)
      end
    end),
    on_exit = vim.schedule_wrap(function()
      local out = parse_cover(tmpfile)
      -- paint whole buffer in gray first
      vim.highlight.range(0, ns, "Comment", { 0, 0 }, { vim.fn.line("$"), 1000 })

      for _, item in pairs(out) do
        local startr = { item.line0, 0 }
        local endr = { item.line1, 1000 } -- TODO: grab line length
        local color = "DiffAdd" -- green color
        if item.ok == "0" then
          color = "DiffDelete"
        end
        vim.highlight.range(0, ns, color, startr, endr, "l")
      end
      vim.fn.delete(tmpfile)
    end),
  }):start()
end

-- add/remove/modify struct tags using gomodifytags
local function modify_tags(action, opts)
  local tags = opts.fargs[1]
  local current_file = vim.fn.expand("%")
  local cmd = "gomodifytags"
  if not vim.fn.executable(cmd) then
    vim.notify("Installing gomodifytags..")
    Job:new({
      command = "go",
      args = { "install", "github.com/fatih/gomodifytags@latest" },
      on_stderr = vim.schedule_wrap(function()
        vim.notify("Error on installing gomodifytags tool", vim.log.levels.ERROR)
      end),
      on_exit = vim.schedule_wrap(function(_, code, _)
        if code == 0 then
          return
        end
        vim.notify("gomodifytags installed")
      end),
    }):sync()
  end

  -- TODO: get with treesitter query
  local line = vim.fn.getline(".")
  local groups = "type%s(%a+)%sstruct"
  local _, _, struct_name = string.find(line, groups)
  if struct_name == nil then
    vim.notify("no struct found")
    return
  end

  local base_action = "-add-tags"
  if action == "remove" then
    base_action = "-clear-tags"
  end

  local args = { "-file", current_file, "-struct", struct_name, base_action, tags }

  local buffer = {}
  Job:new({
    command = cmd,
    args = args,
    on_stdout = vim.schedule_wrap(function(_, data, _)
      table.insert(buffer, data)
    end),
    on_stderr = vim.schedule_wrap(function(_, error)
      vim.api.nvim_err_writeln(error)
    end),
    on_exit = vim.schedule_wrap(function()
      vim.api.nvim_buf_set_lines(0, 0, -1, false, buffer)
    end),
  }):start()
end

-- custom keymaps
vim.keymap.set("n", "<leader>ga", alternate_test, { silent = true, remap = false })
vim.keymap.set("n", "<leader>tc", coverage, { silent = true, remap = false })
vim.keymap.set("n", "<leader>ct", clear_coverage, { silent = true, remap = false })

vim.api.nvim_create_user_command("GoAddTags", function(opts)
  modify_tags("add", opts)
end, { nargs = 1 })
vim.api.nvim_create_user_command("GoRemoveTags", function(opts)
  modify_tags("remove", opts)
end, { nargs = 1 })

-- add automatic go imports
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function(opts)
    local params = vim.lsp.util.make_range_params(0, vim.lsp.util._get_offset_encoding(opts.buf))
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(opts.buf, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(opts.buf))
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})
