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

for _, lang in pairs({ "lua", "sh", "all" }) do
  ls.add_snippets(lang, require("snippets." .. lang), { key = lang })
end

vim.keymap.set(
  "i",
  "<C-k>",
  "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''",
  { expr = true, silent = true }
)

vim.keymap.set("i", "<C-j>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set(
  "i",
  "<C-l>",
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'",
  { expr = true, silent = true }
)

vim.keymap.set("s", "<C-k>", function()
  ls.jump(1)
end, { silent = true })

vim.keymap.set("s", "<C-j>", function()
  ls.jump(-1)
end, { silent = true })
