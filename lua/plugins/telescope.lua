local function get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  path = path and vim.fs.dirname(path) or vim.uv.cwd()
  local root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
  root = root and vim.fs.dirname(root) or vim.uv.cwd()
  return root
end

-- this will return a function that calls telescope.
-- cwd will defautlt to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local function telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
    if builtin == "files" then
      if vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    config = function(_)
      local t = require("telescope")
      local actions = require("telescope.actions")
      t.setup({
        defaults = {
          sorting_strategy = "ascending",
          winblend = 0,
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {},
        },
      })
      t.load_extension("fzf")
    end,
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader><leader>", ":Telescope buffers<CR>", silent = true },
      { "<leader>lg", telescope("live_grep"), silent = true },
      { "<leader>ff", telescope("files"), silent = true },
      { "<leader>fC", telescope("files", { cwd = vim.env.HOME .. "/code/", hidden = true }), silent = true },
      {
        "<leader>fP",
        telescope("files", { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") }),
        silent = true,
      },
      {
        "<leader>H",
        function()
          require("telescope.builtin").help_tags()
        end,
      },
    },
  },
}
