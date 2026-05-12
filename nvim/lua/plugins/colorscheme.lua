return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        italic_inlayhints = true,
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
}
