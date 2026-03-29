return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        -- don't use Ctrl-Space anymore
        ["<C-space>"] = false,

        -- Tab opens completion manually
        ["<Tab>"] = { "show", "fallback" },
      },

      completion = {
        menu = { auto_show = false },
        ghost_text = { enabled = false },
      },

      sources = {
        default = { "lsp" },
      },
    },
  },
}
