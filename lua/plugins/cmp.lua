-- nvim-compe configs
-- configure completion
local cmp = require("cmp")
local compare = require("cmp.config.compare")

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "buffer" },
    { name = "path" },
    { name = "vsnip" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<C-y>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
      else
        fallback()
      end
    end,
  },
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
