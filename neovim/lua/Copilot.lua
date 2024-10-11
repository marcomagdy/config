-- execute a command in normal mode to toggle Copilot.
-- Since there is no command to toggle Copilot, we have to create a function to check if Copilot is enabled or not.

function copilot_toggle()
    if vim.g.copilot_enabled == 1 then
        vim.g.copilot_enabled = 0
    else
        vim.g.copilot_enabled = 1
    end
    vim.cmd("Copilot status")
end

vim.api.nvim_set_keymap("n", "<leader>!", ":lua copilot_toggle()<CR>", { noremap = true, silent = true })
