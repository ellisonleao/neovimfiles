return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },
      cmdline = { enabled = false },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 0,
            async = true,
          },
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
