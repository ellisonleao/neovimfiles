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
