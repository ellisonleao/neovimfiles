local ls = require("luasnip")

local snippets = {
  ls.parser.parse_snippet(
    { trig = "for" },
    [[ 
for ${1:k}, ${2:v} in pairs(${3:table}) do 
end
]]
  ),
  ls.parser.parse_snippet({ trig = "req" }, [[require("${1:module}")]]),
  ls.parser.parse_snippet({ trig = "pr" }, [[print("${1:val}")]]),
}

return snippets
