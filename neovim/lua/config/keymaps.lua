-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function select_line()
  vim.cmd("normal! ^v$")
end

vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set({ "o", "x" }, "al", select_line, { desc = "around line" })
vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>", { silent = true, desc = "Hide highlight" })

vim.keymap.set({ "n", "v", "o" }, "0", "$", { noremap = true })

--
function copilot_toggle()
  if vim.g.copilot_enabled == 1 then
    vim.g.copilot_enabled = 0
  else
    vim.g.copilot_enabled = 1
  end
  vim.cmd("Copilot status")
end

vim.api.nvim_set_keymap("n", "<leader>!", ":lua copilot_toggle()<CR>", { noremap = true, silent = true })
