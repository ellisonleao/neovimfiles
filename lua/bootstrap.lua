local fn = vim.fn
local packer_bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Installing packer...")
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

local packer_group = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { group = packer_group, pattern = "bootstrap.lua", command = "source <afile> | PackerCompile profile=true" }
)

-- load plugins
return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "junegunn/fzf", run = ":call fzf#install()" })

  -- plugin development and utils
  use({
    "nvim-lua/plenary.nvim",
    config = function()
      vim.keymap.set("n", "<leader>tp", function()
        require("plenary.test_harness").test_directory(vim.fn.expand("%:p"))
      end, { noremap = true, silent = true })
    end,
  })

  use("tpope/vim-dotenv")

  use({
    "nvim-lua/telescope.nvim",
    requires = { "nvim-lua/popup.nvim" },
  })
  use({ "mjlbach/babelfish.nvim" })
  use({ "folke/lua-dev.nvim" })

  -- git
  use({
    "TimUntersberger/neogit",
    requires = {
      "sindrets/diffview.nvim",
    },
    config = function()
      require("neogit").setup({
        kind = "split",
        integrations = { diffview = true },
        disable_commit_confirmation = true,
      })
      local opts = { noremap = true, silent = true }
      local mappings = {
        { "n", "<leader>gc", [[<Cmd>Neogit commit<CR>]], opts },
        { "n", "<leader>gp", [[<Cmd>Neogit push<CR>]], opts },
        { "n", "<leader>gs", [[<Cmd>Neogit<CR>]], opts },
      }

      for _, m in pairs(mappings) do
        vim.keymap.set(unpack(m))
      end
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      local bar = "┃"
      require("gitsigns").setup({
        numhl = true,
        signs = {
          add = { text = bar },
          change = { text = bar },
          delete = { text = bar },
          topdelete = { text = bar },
          changedelete = { text = bar },
        },
      })
    end,
  })

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
  use("~/code/dotenv.nvim")
  use({
    "~/code/glow.nvim",
    config = function()
      require("glow").setup({ style = "dark", width = 200 })
    end,
  })
  -- use({ "~/code/gruvbox.nvim" })
  use({
    "ellisonleao/carbon-now.nvim",
    config = function()
      require("carbon-now").setup({ options = { theme = "nord", font_family = "JetBrains Mono" } })
    end,
  })

  use({
    "WhoIsSethDaniel/goldsmith.nvim",
    run = ":GoInstallBinaries",
    requires = { "antoinemadec/FixCursorHold.nvim" },
  })

  -- editor
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- lsp, completion, linting and snippets
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
    end,
  })

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
  use({ "neovim/nvim-lspconfig", requires = { "williamboman/nvim-lsp-installer" } })

  -- visual
  use({ "projekt0n/github-nvim-theme" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "rcarriga/nvim-notify" })

  -- buffer tabs at top
  use({
    "akinsho/bufferline.nvim",
    config = function()
      -- TODO(ellison): weird hack to get the setup working with termguicolors
      vim.schedule(function()
        require("bufferline").setup()
      end)
    end,
  })

  -- treesitter
  use({ "nvim-treesitter/nvim-treesitter" })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" })
  use({ "nvim-treesitter/playground" })

  -- sql
  use("tpope/vim-dadbod")
  use({ "kristijanhusak/vim-dadbod-completion" })
  use({ "kristijanhusak/vim-dadbod-ui" })

  if packer_bootstrap then
    vim.notify("Installing plugins...")
    require("packer").sync()
  end
end)
