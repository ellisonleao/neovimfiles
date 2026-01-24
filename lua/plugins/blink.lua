return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
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
          sql = { "dadbod" },
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lsp = { score_offset = 1000 },
          lazydev = {
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          snippets = { opts = { friendly_snippets = true } },
          dadbod = { module = "vim_dadbod_completion.blink" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
