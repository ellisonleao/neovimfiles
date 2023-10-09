local ls = require("luasnip")
local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("im", fmt([[import "{}"]], { i(1) })),
  s("bp", fmt([[breakpoint(){}]], { i(1) })),
  s(
    "ifm",
    fmt(
      [[
def main():
    {}

if __name__ == "__main__":
    main()
]],
      { i(1) }
    )
  ),
}
