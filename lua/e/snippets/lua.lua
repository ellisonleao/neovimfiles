local ls = require("luasnip")
local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local t = ls.text_node

return {
  s(
    "for",
    fmt(
      "for {}, {} in {}({}) do\n  {}\nend",
      { i(1, "k"), i(2, "v"), c(3, { t("pairs"), t("ipairs") }), i(4, "item"), i(0) }
    )
  ),
  s("pr", fmt('print("{}")', { i(1, "val") })),
  s("req", fmt('local {} = require("{}")', { i(1, "module"), rep(1) })),
  s("lf", fmt("local function {}({})\n  {}\nend", { i(1, "func"), i(2, "param"), i(0) })),
  s("mf", fmt("M.{} = function({})\n  {}\nend", { i(1, "func"), i(2, "param"), i(0) })),
}
