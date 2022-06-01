-- colorscheme configs
local ok, theme = pcall(require, "github-theme")
if not ok then
  return
end

theme.setup({ theme_style = "light", dark_float = true })
