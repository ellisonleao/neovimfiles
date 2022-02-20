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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost bootstrap.lua source <afile> | PackerCompile profile=true
  augroup end
]])

PackerReinstall = function(name)
  if package.loaded["packer"] == nil then
    R("packer")
  end

  local utils = require("packer.plugin_utils")
  local suffix = "/" .. name

  local opt, start = utils.list_installed_plugins()
  for _, group in pairs({ opt, start }) do
    if group ~= nil then
      for dir, _ in pairs(group) do
        if dir:sub(-string.len(suffix)) == suffix then
          vim.ui.input({ prompt = "Reinstall " .. dir .. "? [y/n] " }, function(confirmation)
            if string.lower(confirmation) ~= "y" then
              return
            end
            os.execute("cd " .. dir .. " && git fetch --progress origin && git reset --hard origin")
            vim.cmd("PackerSync")
          end)
        end
      end
    end
  end
end

vim.cmd("command! -nargs=1 PackerReinstall lua PackerReinstall <f-args>")

-- load plugins
return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "junegunn/fzf", run = ":call fzf#install()" })

  -- plugin development and utils
  use({
    "nvim-lua/plenary.nvim",
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>tp",
        ":lua require('plenary.test_harness').test_directory(vim.fn.expand('%:p'))<CR>",
        { noremap = true, silent = true }
      )
    end,
  })

  use({
    "nvim-lua/telescope.nvim",
    requires = { "nvim-lua/popup.nvim" },
  })
  use({ "mjlbach/babelfish.nvim" })
  use({ "folke/lua-dev.nvim" })

  -- use({ "github/copilot.vim" })
  use({ "norcalli/nvim-colorizer.lua" })

  -- tpopes
  use({ "tpope/vim-dotenv" })

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
        vim.api.nvim_set_keymap(unpack(m))
      end
    end,
  })

  use({
    "pwntester/octo.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ numhl = true })
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
        vim.api.nvim_set_keymap(unpack(m))
      end
    end,
  })

  -- local
  use({ "~/code/glow.nvim" })
  use({ "~/code/carbon-now.nvim" })

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
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
      vim.api.nvim_set_keymap("n", "<leader>xx", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
  })
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
  use({
    "neovim/nvim-lspconfig",
    requires = { "williamboman/nvim-lsp-installer" },
  })
  use({ "Pocco81/TrueZen.nvim" })

  -- visual
  use({ "folke/tokyonight.nvim" })
  use({ "~/code/gruvbox.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({
    "mhinz/vim-startify",
    config = function()
      vim.g.startify_bookmarks = { "~/.config/nvim/lua" }
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
  })

  use({ "rcarriga/nvim-notify" })

  -- buffer tabs at top
  use({
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({ options = { numbers = "both" } })
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
