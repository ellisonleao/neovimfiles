H.pack_add({
  "rafamadriz/friendly-snippets",
  {
    src = "saghen/blink.cmp",
    version = vim.version.range("1.*"),
    data = {
      install = function(ev)
        vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
      end,
    },
  },
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  cmdline = { enabled = false },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      lsp = { score_offset = 1000 },
      lazydev = {
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      snippets = { opts = { friendly_snippets = true } },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
