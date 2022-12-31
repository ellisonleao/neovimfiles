local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local p = require("luasnip.extras").partial

local calculate_comment_string = require("Comment.ft").calculate
local region = require("Comment.utils").get_region

local get_comment_string = function()
  local line_comment = 1
  local cstring = calculate_comment_string({ ctype = line_comment, range = region() }) or ""
  local cstring_table = vim.split(cstring, "%s", { plain = true, trimempty = true })
  if #cstring_table == 0 then
    return ""
  end
  return cstring_table[1]
end

local snippets = {
  s("todo", {
    p(get_comment_string),
    t(" "),
    c(1, { t("TODO"), t("FIXME"), t("XXX") }),
    t("(ellisonleao): "),
  }),
  s("dmy", {
    p(os.date, "%d-%m-%Y"),
  }),
}

return snippets
