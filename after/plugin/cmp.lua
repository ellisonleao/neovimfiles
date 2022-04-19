-- nvim-cmp configs
local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

local ok, luasnip = pcall(require, "luasnip")
if not ok then
  return
end

local compare = require("cmp.config.compare")

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  experimental = {
    ghost_test = false,
    native_menu = false,
  },
  sources = {
    { name = "gh_issues" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
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

local group = vim.api.nvim_create_augroup("DadbodSQL", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  group = group,
  callback = function()
    vim.schedule(function()
      require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    end)
  end,
})
