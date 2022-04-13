local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local p = require("luasnip.extras").partial

local snippets = {
  -- TODO: dynamic insert commentstring
  s("todo", {
    t({ "TODO(ellison)" }),
  }),
  s("dmy", {
    p(os.date, "%d-%m-%Y"),
  }),
}

return snippets
