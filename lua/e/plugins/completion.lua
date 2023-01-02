local setup_cmp = function()
  -- nvim-cmp configs
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local compare = require("cmp.config.compare")
  local lspkind = require("lspkind")

  lspkind.init()

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "gh_issues" },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        menu = {
          nvim_lua = "[lua-api]",
          nvim_lsp = "[lsp]",
          path = "[path]",
          luasnip = "[snip]",
          buffer = "[buf]",
          gh_issues = "[issue]",
        },
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ["<tab>"] = cmp.config.disable,
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }, { "i", "c" }),
      ["<C-n>"] = {
        i = cmp.mapping.select_next_item(),
      },
      ["<C-p>"] = {
        i = cmp.mapping.select_prev_item(),
      },
      ["<C-Space>"] = cmp.mapping({
        i = cmp.mapping.complete(),
        c = function(_)
          if cmp.visible() then
            if not cmp.confirm({ select = true }) then
              return
            end
          else
            cmp.complete()
          end
        end,
      }),
    }),

    sorting = {
      comparators = {
        compare.kind,
        compare.offset,
        compare.exact,
        compare.score,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
  })

  -- gh issues cmp source
  local Job = require("plenary.job")
  local source = {}

  source.new = function()
    local self = setmetatable({ cache = {} }, { __index = source })

    return self
  end

  source.complete = function(self, _, callback)
    local bufnr = vim.api.nvim_get_current_buf()

    if not self.cache[bufnr] then
      Job:new({
        "gh",
        "issue",
        "list",
        "--limit",
        "1000",
        "--json",
        "title,number,body",

        on_exit = function(job)
          local result = job:result()
          local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
          if not ok then
            print("Failed to parse gh result")
            return
          end

          local items = {}
          for _, gh_item in ipairs(parsed) do
            gh_item.body = string.gsub(gh_item.body or "", "\r", "")

            table.insert(items, {
              label = string.format("#%s", gh_item.number),
              documentation = {
                kind = "markdown",
                value = string.format("# %s\n\n%s", gh_item.title, gh_item.body),
              },
            })
          end

          callback({ items = items, isIncomplete = false })
          self.cache[bufnr] = items
        end,
      }):start()
    else
      callback({ items = self.cache[bufnr], isIncomplete = false })
    end
  end

  source.get_trigger_characters = function()
    return { "#" }
  end

  source.is_available = function()
    local ft = vim.bo.filetype
    return ft:lower() == "gitcommit" or ft:lower() == "neogitcommitmessage"
  end

  require("cmp").register_source("gh_issues", source.new())
end

local setup_luasnip = function()
  local ls = require("luasnip")
  local types = require("luasnip.util.types")

  ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { " <- Current Choice", "NonTest" } },
        },
      },
    },
  })

  for _, lang in pairs({ "lua", "go", "sh", "all" }) do
    ls.add_snippets(lang, require("e.snippets." .. lang), { key = lang })
  end
end

return {
  {
    "L3MON4D3/LuaSnip",
    config = setup_luasnip,
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
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
    },
    config = setup_cmp,
  },
}
