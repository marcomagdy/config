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
        args = function()
          local raw_format = [[
          BasedOnStyle: WebKit,
          BreakBeforeBraces: Stroustrup,
          ColumnLimit: 120
        ]]
          -- Build args based on Vim settings
          local args = { "--style={" .. raw_format .. "}" }

          return args
        end,
      },
    },
  },
}
