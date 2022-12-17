vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

-- load plugins
return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "norcalli/nvim-colorizer.lua" })

  -- plugin development and utils
  use({
    "nvim-lua/plenary.nvim",
    config = function()
      vim.keymap.set("n", "<leader>tp", function()
        require("plenary.test_harness").test_directory("tests")
      end, { noremap = true, silent = true })
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({ "folke/neodev.nvim" })

  -- git
  use({ "tpope/vim-fugitive" })
  use({ "tpope/vim-rhubarb" })
  use({ "lewis6991/gitsigns.nvim" })

  -- testing
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
    },
  })

  -- personal
  use({
    "~/code/dotenv.nvim",
    config = function()
      require("dotenv").setup()
    end,
    cond = vim.fn.isdirectory(vim.fn.expand("~/code/dotenv.nvim/")) == 1,
  })
  use({
    "~/code/glow.nvim",
    config = function()
      require("glow").setup()
    end,
    cond = vim.fn.isdirectory(vim.fn.expand("~/code/glow.nvim/")) == 1,
  })
  use({ "~/code/gruvbox.nvim", cond = vim.fn.isdirectory(vim.fn.expand("~/code/gruvbox.nvim/")) == 1 })
  use({
    "~/code/carbon-now.nvim",
    config = function()
      require("carbon-now").setup({ options = { theme = "nord", font_family = "JetBrains Mono" } })
    end,
    cond = vim.fn.isdirectory(vim.fn.expand("~/code/carbon-now.nvim/")) == 1,
  })

  -- editor
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- lsp, completion, linting and snippets
  use({ "jose-elias-alvarez/null-ls.nvim" })

  use({ "L3MON4D3/LuaSnip" })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
    },
  })
  use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" })

  -- visual
  use({ "projekt0n/github-nvim-theme" })
  use({ "nvim-tree/nvim-web-devicons" })
  use({ "nvim-lualine/lualine.nvim" })
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  -- buffer tabs at top
  use({ "akinsho/bufferline.nvim", tag = "v3.*" })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
  })
end)
