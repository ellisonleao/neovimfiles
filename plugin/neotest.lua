---@diagnostic disable: missing-parameter
local neotest = require("neotest")

local opts = { noremap = true, silent = true }
local mappings = {
  {
    "n",
    "<leader>t",
    function()
      neotest.run.run()
    end,
    opts,
  }, -- call test for function in cursor
  {
    "n",
    "<leader>tt",
    function()
      neotest.run.run(vim.fn.expand("%"))
    end,
    opts,
  }, -- call test for current file
  {
    "n",
    "<leader>ts",
    function()
      neotest.summary.toggle()
    end,
    opts,
  },
}

for _, m in pairs(mappings) do
  vim.keymap.set(unpack(m))
end

neotest.setup({
  adapters = {
    require("neotest-go"),
    require("neotest-plenary"),
  },
  consumers = {
    always_open_output = function(client)
      local async = require("neotest.async")
      client.listeners.results = function(adapter_id, results)
        local file_path = async.fn.expand("%:p")
        local row = async.fn.getpos(".")[2] - 1
        local position = client:get_nearest(file_path, row, {})
        if not position then
          return
        end
        local pos_id = position:data().id
        if not results[pos_id] then
          return
        end
        neotest.output.open({ position_id = pos_id, adapter = adapter_id })
      end
    end,
  },
})
