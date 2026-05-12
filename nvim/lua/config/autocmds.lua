-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- if file build/build.ninja exists, use ninja to build
local function set_make_program()
  if vim.fn.filereadable("build/build.ninja") == 1 then
    vim.o.makeprg = "ninja -C build"
  elseif vim.fn.filereadable("Makefile") == 1 then
    vim.o.makeprg = "make"
  else
    vim.o.makeprg = ""
  end
end

-- Use an autocommand to check for and load local configuration on directory change
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    set_make_program()
  end,
})
