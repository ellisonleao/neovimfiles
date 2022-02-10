local ls = require("luasnip")
local s = ls.snippet
local p = require("luasnip.extras").partial

local snippets = {
  s("dmy", {
    p(os.date, "%d-%m-%Y"),
  }),
}

return snippets
