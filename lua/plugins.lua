local packer_group = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { group = packer_group, pattern = "plugins.lua", command = "source <afile> | PackerCompile profile=true" }
)

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

  use("tpope/vim-dotenv")

  use({
    "nvim-lua/telescope.nvim",
    requires = { "nvim-lua/popup.nvim" },
  })
  use({ "folke/lua-dev.nvim" })

  -- git
  use({
    "TimUntersberger/neogit",
    requires = {
      "sindrets/diffview.nvim",
    },
  })

  use({ "lewis6991/gitsigns.nvim" })

  -- testing
  use({
    "vim-test/vim-test",
    config = function()
      local opts = { noremap = true, silent = true }
      local mappings = {
        { "n", "<leader>t", [[<Cmd>TestNearest<CR>]], opts }, -- call test for function in cursor
        { "n", "<leader>tt", [[<Cmd>TestFile<CR>]], opts }, -- call test for current file
      }

      for _, m in pairs(mappings) do
        vim.keymap.set(unpack(m))
      end
    end,
  })

  -- personal
  -- use("~/code/dotenv.nvim")
  use({
    "~/code/glow.nvim",
    config = function()
      require("glow").setup({ style = "dark", width = 200 })
    end,
  })
  use({ "~/code/gruvbox.nvim" })
  use({
    "ellisonleao/carbon-now.nvim",
    config = function()
      require("carbon-now").setup({ options = { theme = "nord", font_family = "JetBrains Mono" } })
    end,
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
  use({ "williamboman/nvim-lsp-installer", "neovim/nvim-lspconfig", "Maan2003/lsp_lines.nvim" })

  -- visual
  use({ "projekt0n/github-nvim-theme" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "rcarriga/nvim-notify" })

  -- buffer tabs at top
  use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
  })

  -- sql
  use("tpope/vim-dadbod")
  use({ "kristijanhusak/vim-dadbod-completion" })
  use({ "kristijanhusak/vim-dadbod-ui" })
end)
