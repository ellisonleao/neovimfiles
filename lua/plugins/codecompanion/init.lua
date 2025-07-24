return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  opts = {
    strategies = {
      chat = { adapter = "copilot" },
      inline = { adapter = "copilot" },
      agent = { adapter = "copilot" },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          -- MCP Tools
          make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          show_result_in_chat = true, -- Show tool results directly in chat buffer
          format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          -- MCP Resources
          make_vars = true, -- Convert MCP resources to #variables for prompts
          -- MCP Prompts
          make_slash_commands = true, -- Add MCP prompts as /slash commands
        },
      },
    },
  },
  keys = {
    { "<leader>ccc", ":CodeCompanionChat Toggle<CR>", { "n", "v" }, silent = true },
    { "<leader>cca", ":CodeCompanionActions<CR>", { "n", "v" }, silent = true },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
      config = function()
        require("mcphub").setup()
      end,
    },
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
}
