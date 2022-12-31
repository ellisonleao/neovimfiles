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
  ls.add_snippets(lang, require("snippets." .. lang), { key = lang })
end
