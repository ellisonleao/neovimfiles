local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local d = ls.dynamic_node
local i = ls.insert_node
local p = require("luasnip.extras").partial

local date_input = function(args, state, fmt)
  local fmt = fmt or "%d-%m-%Y"
  return sn(nil, i(1, os.date(fmt)))
end

local snippets = {
  s("dmy", {
    p(os.date, "%d-%m-%Y"),
  }),
  s("trigger", {
    t({ "", "After expanding, the cursor is here ->" }),
    i(1),
    t({ "After jumping forward once, cursor is here ->" }),
    i(2),
    t({ "", "After jumping once more, the snippet is exited there ->" }),
    i(0),
  }),
}

return snippets
