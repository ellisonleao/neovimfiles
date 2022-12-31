-- load global opts
require("e.options")

-- global keymaps
require("e.keymaps")

-- global autocmds
require("e.autocmds")

-- global filetype checks
require("e.filetypes")

-- load plugins
return require("lazy").setup(
  {
    -- visual
    { "norcalli/nvim-colorizer.lua" },
    { "nvim-tree/nvim-web-devicons" },
    {
      "projekt0n/github-nvim-theme",
      lazy = false,
      priority = 1000,
      config = function()
        require("github-theme").setup({ theme_style = "light", dark_float = true })
      end,
    },
    {
      "akinsho/bufferline.nvim",
      lazy = false,
      priority = 999,
      version = "v3.*",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function()
        require("bufferline").setup({
          options = {
            separator_style = "slant",
          },
        })
      end,
      keys = {
        {
          "<leader>z",
          function()
            require("bufferline").cycle(-1)
          end,
        }, -- move to the previous buffer
        {
          "<leader>q",
          function()
            require("bufferline").cycle(-1)
          end,
        }, -- move to the previous buffer (same option, different key)
        {
          "<leader>x",
          function()
            require("bufferline").cycle(1)
          end,
        }, -- move to the next buffer
        {
          "<leader>w",
          function()
            require("bufferline").cycle(1)
          end,
        }, -- move to the next buffer (same option, different key)
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("e.lualine")
      end,
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      config = function()
        require("e.telescope")
      end,
      requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
      keys = {
        {
          "<leader>lg",
          function()
            require("telescope.builtin").live_grep()
          end,
        },
        {
          "<leader>ff",
          function()
            require("telescope.builtin").find_files({ hidden = true })
          end,
        },
        {
          "<leader>H",
          function()
            require("telescope.builtin").help_tags()
          end,
        },
      },
    },

    -- plugin development and utils
    {
      "nvim-lua/plenary.nvim",
      keys = {
        {
          "<leader>tp",
          function()
            require("plenary.test_harness").test_directory("tests")
          end,
        },
      },
    },

    { "folke/neodev.nvim", ft = "lua" },

    -- git
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    },

    -- testing
    {
      "nvim-neotest/neotest",
      lazy = true,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-go",
        "nvim-neotest/neotest-plenary",
      },
      config = function()
        require("e.neotest")
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

    -- personal
    {
      dir = "~/code/dotenv.nvim",
      config = function()
        require("dotenv").setup()
      end,
    },
    {
      dir = "~/code/glow.nvim",
      config = function()
        require("glow").setup()
      end,
    },
    { dir = "~/code/gruvbox.nvim" },
    {
      dir = "~/code/carbon-now.nvim",
      config = function()
        require("carbon-now").setup({ options = { theme = "nord", font_family = "JetBrains Mono" } })
      end,
    },

    -- editor
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },

    -- lsp, completion, linting and snippets
    {
      "L3MON4D3/LuaSnip",
      config = function()
        require("e.luasnip")
      end,
      keys = {
        {
          "<C-k>",
          function()
            if require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            end
          end,
          mode = { "i", "s" },
        },
        {
          "<C-j>",
          function()
            if require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            end
          end,
          mode = { "i", "s" },
        },
        {
          "<C-l>",
          function()
            if require("luasnip").choice_active() then
              require("luasnip").change_choice(1)
            end
          end,
          mode = "i",
        },
        {
          "<C-u>",
          function()
            require("luasnip.extras.select_choice")
          end,
          mode = "i",
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("e.cmp")
        require("e.cmp_gh_issue")
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufReadPre",
      dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
      },
      config = function()
        require("e.lsp")
      end,
    },

    -- treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("e.treesitter")
      end,
    },
    { "nvim-treesitter/playground", dependencies = { "nvim-treesitter/nvim-treesitter" } },
    { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  },
  {
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  }
)
