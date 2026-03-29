return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang_format" },
      c = { "clang_format" },
      objcpp = { "clang_format" },
    },
    formatters = {
      clang_format = {
        append_args = { "--fallback-style=WebKit" },
      },
    },
  },
}
