-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "fzf"

vim.opt.textwidth = 120
vim.opt.colorcolumn = "120"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Don't copy all the yanked text to the system clipboard
vim.opt.clipboard = ""

-- Disable relative line numbers
vim.opt.relativenumber = false

-- show neovim's intro message if opened without a file
vim.opt.shortmess:remove("I")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("intro")
    end
  end,
})
