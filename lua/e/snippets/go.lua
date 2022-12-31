local ls = require("luasnip")
local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local t = ls.text_node

local snippets = {
  s("im", fmt([[import "{}"]], { i(1) })),
  s(
    "fnm",
    fmt(
      [[
func main() {{
    {}
}}]],
      { i(0) }
    )
  ),
  s("cos", fmt([[const {} = {}]], { i(1), i(2) })),
  s(
    "tys",
    fmt(
      [[
type {} struct {{
    {}
}}]],
      { i(1), i(0) }
    )
  ),
  s(
    "tyi",
    fmt(
      [[
type {} interface {{
    {} 
}}]],
      { i(1), i(0) }
    )
  ),
  s(
    "for",
    fmt(
      [[
for {} := range {} {{
    {}
}}]],
      { c(1, { t("key, val"), t("_, val") }), i(2), i(0) }
    )
  ),
  s(
    "iferr",
    fmt(
      [[
if err != nil {{
    return {}
}}]],
      { c(1, { t("err"), t("nil, err") }) }
    )
  ),
}

return snippets
