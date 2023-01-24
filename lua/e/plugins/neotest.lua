return {
  {
    "nvim-neotest/neotest",
    cmd = "Neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
    },
    opts = function()
      local neotest = require("neotest")
      return {
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
      }
    end,
    keys = {
      {
        "<leader>t",
        function()
          require("neotest").run.run()
        end,
      }, -- call test for function in cursor
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
      }, -- call test for current file
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
      },
    },
  },
}