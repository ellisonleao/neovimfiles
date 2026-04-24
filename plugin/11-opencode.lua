H.pack_add({
  { src = "nickjvandyke/opencode.nvim", version = "main" },
})

H.set_keymaps({
  {
    { "n", "x" },
    "<C-a>",
    function()
      require("opencode").ask("@this: ", { submit = true })
    end,
  },
  {
    { "n", "x" },
    "<C-x>",
    function()
      require("opencode").select()
    end,
  },
  {
    { "n", "t" },
    "<C-.>",
    function()
      require("opencode").toggle()
    end,
  },
  {
    { "n", "x" },
    "go",
    function()
      return require("opencode").operator("@this ")
    end,
  },
  {
    "n",
    "goo",
    function()
      return require("opencode").operator("@this ") .. "_"
    end,
  },
  {
    "n",
    "<S-C-u>",
    function()
      require("opencode").command("session.half.page.up")
    end,
  },
  {
    "n",
    "<S-C-d>",
    function()
      require("opencode").command("session.half.page.down")
    end,
  },
})
