local packer_exists = pcall(vim.cmd, [[ packadd packer.nvim ]])
if not packer_exists then
  local dest = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))
  local repo_url = "https://github.com/wbthomason/packer.nvim"

  vim.fn.mkdir(dest, "p")

  print("Downloading packer..")
  vim.fn.system(string.format("git clone %s %s", repo_url, dest .. "packer.nvim"))
  vim.cmd([[packadd packer.nvim]])
  vim.schedule_wrap(function()
    vim.cmd("PackerSync")
    print("plugins installed")
  end)
end

vim.cmd([[autocmd BufWritePost bootstrap.lua PackerCompile]])

-- load plugins
return require("packer").startup(function(use)

  use {"wbthomason/packer.nvim"}
  use {"junegunn/fzf", run = ":call fzf#install()"}
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- calendar and task list
  use {
    "kristijanhusak/orgmode.nvim",
    config = function()
      require("orgmode").setup {
        org_agenda_files = {"~/.orgmode/*"},
        org_default_notes_file = {"~/.orgmode/notes.org"},
      }
    end,
  }

  -- tpopes
  use {"tpope/vim-surround"}
  use {"tpope/vim-repeat"}

  -- git
  use {
    "tpope/vim-fugitive",
    requires = {"tpope/vim-rhubarb"},
    config = function()
      local opts = {noremap = true, silent = true}
      local mappings = {
        {"n", "<leader>gc", [[<Cmd>Git commit<CR>]], opts},
        {"n", "<leader>gp", [[<Cmd>Git push<CR>]], opts},
        {"n", "<leader>gs", [[<Cmd>G<CR>]], opts},
      }

      for _, m in pairs(mappings) do
        vim.api.nvim_set_keymap(unpack(m))
      end
    end,
  }
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {numhl = true}
    end,
  }

  -- testing
  use {
    "vim-test/vim-test",
    config = function()
      local opts = {noremap = true, silent = true}
      local mappings = {
        {"n", "<leader>t", [[<Cmd>TestNearest<CR>]], opts}, -- call test for function in cursor
        {"n", "<leader>tT", [[<Cmd>TestFile<CR>]], opts}, -- call test for current file
      }

      for _, m in pairs(mappings) do
        vim.api.nvim_set_keymap(unpack(m))
      end
    end,
  }

  -- local
  use {"~/code/glow.nvim"}

  -- use {
  --   "~/code/go.nvim",
  --   config = function()
  --     require("go").config({lsp = require("plugins.lsp").config()})
  --     -- require("go").config()
  --   end,
  --   ft = {"go"},
  -- }
  use {"fatih/vim-go", run = {"GoUpdateBinaries"}, ft = {"go"}}

  -- plugin development and utils
  use {"nvim-lua/plenary.nvim"}
  use {
    "nvim-lua/telescope.nvim",
    config = function()
      require("plugins.telescope")
    end,
    requires = {"nvim-lua/popup.nvim"},
  }
  use {"mjlbach/babelfish.nvim"}
  use {"folke/lua-dev.nvim"}

  -- editor
  use {
    "b3nj5m1n/kommentary",
    config = function()
      require("kommentary.config").configure_language("default", {
        prefer_single_line_comments = true,
      })
    end,
  }

  use {
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter")
    end,
  }

  -- lsp, completion, linting and snippets
  use {"rafamadriz/friendly-snippets"}
  use {
    "glepnir/lspsaga.nvim",
    config = function()
      require("plugins.lspsaga")
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
    },
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
    requires = {"kabouzeid/nvim-lspinstall"},
  }
  use {"Pocco81/TrueZen.nvim"}

  -- visual
  use {"folke/tokyonight.nvim"}
  use {"kyazdani42/nvim-web-devicons"}
  use {
    "mhinz/vim-startify",
    config = function()
      vim.g.startify_bookmarks = {"~/.config/nvim/lua"}
    end,
  }

  use {"lukas-reineke/indent-blankline.nvim", config=function() 
    vim.opt.list = true
    vim.opt.listchars:append("eol:↴")
    require("indent_blankline").setup({
      buftype_exclude = {"terminal", "packer", "startify"},
      show_end_of_line = true,
    })
  end} 

  use {
    "shadmansaleh/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end
  }

  -- buffer tabs at top
  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({options = {numbers = "both"}})
    end,
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.treesitter").config()
    end,
  }
end)
