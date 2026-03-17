return {
  "bkad/CamelCaseMotion",
  init = function()
    vim.keymap.set("n", "<S-W>", "<Plug>CamelCaseMotion_w", { silent = true, desc = "CamelCaseMotion fwd" })
    vim.keymap.set("n", "<S-B>", "<Plug>CamelCaseMotion_b", { silent = true, desc = "CamelCaseMotion back" })
  end,
}
