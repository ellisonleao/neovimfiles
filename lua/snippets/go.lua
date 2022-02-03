local ls = require("luasnip")

local snippets = {
  ls.parser.parse_snippet({ trig = "im" }, [[import "${1:package}"]]),
  ls.parser.parse_snippet({ trig = "cos" }, [[const ${1:name} = ${2:value}]]),
  ls.parser.parse_snippet(
    { trig = "tys" },
    [[type ${1:name} struct{
    $0
}]]
  ),
  ls.parser.parse_snippet({ trig = "tyf" }, [[type ${1:name} func($3) $4]]),
  ls.parser.parse_snippet(
    { trig = "tyi" },
    [[type ${1:name} interface{
  $0
}]]
  ),
  ls.parser.parse_snippet(
    { trig = "forra" },
    [[for ${1:_, }${2:v} := range ${3:v} {
    $0
}]]
  ),
  ls.parser.parse_snippet(
    { trig = "iferr" },
    [[if err != nil {
    ${1:return ${2:nil, }${3:err}}
}]]
  ),
}

return snippets
