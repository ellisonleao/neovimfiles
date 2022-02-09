local ls = require("luasnip")
local s = ls.s 
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets = {
  ls.parser.parse_snippet(
    { trig = "for" },
    [[ 
for ${1:k}, ${2:v} in pairs(${3:table}) do 
end
]]
  ),
  ls.parser.parse_snippet({ trig = "pr" }, [[print("${1:val}")]]),
  s("req", fmt("local {} = require(\"{}\")", {i(1, "module"), rep(1)})),
}

return snippets
