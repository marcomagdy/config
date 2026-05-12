-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function select_line()
  vim.cmd("normal! ^v$")
end

vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set({ "o", "x" }, "al", select_line, { desc = "around line" })
vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>", { silent = true, desc = "Hide highlight" })

vim.keymap.set("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "t", "n" }, "<C-\\>", "<C-\\><C-n>:ToggleTerm direction=float<CR>", { desc = "Toggle terminal" })

vim.keymap.set({ "n", "v", "o" }, "0", "$", { noremap = true })

--
local function copilot_toggle()
  if vim.g.copilot_enabled == 1 then
    vim.g.copilot_enabled = 0
  else
    vim.g.copilot_enabled = 1
  end
  vim.cmd("Copilot status")
end

vim.keymap.set("n", "<leader>!", copilot_toggle, { noremap = true, silent = true, desc = "Toggle Copilot" })

-- yank the current file's path to the system clipboard
vim.keymap.set("n", "<leader>fy", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied " .. path)
end, { desc = "Copy file's absolute path" })
