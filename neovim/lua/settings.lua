require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "cpp", "swift"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "c", "cpp", "rust", "swift"}
    },
}

local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0}) -- 'gd' go to definition
        vim.keymap.set("n", "gi", vim.lsp.buf.hover, {buffer=0}) -- 'gi' go to info
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0}) -- 'ca' code-action
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer=0})
    end
}
local diagnostic_config = {
        update_in_insert = false,
        underline = true,
        virtual_text = {
            severity = vim.diagnostic.severity.ERROR,
            source = true,
            spacing = 10,
        },
        -- show signs
        signs = {
            active = signs,
        },
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

vim.diagnostic.config(diagnostic_config)
