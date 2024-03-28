require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = { "typescript", "c", "lua", "rust", "cpp", "swift", "go", "c_sharp" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {  },

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
        additional_vim_regex_highlighting = { "typescript", "c", "cpp", "rust", "swift"}
    },
}

require("toggleterm").setup {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = -50,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
}

function find_under_cursor()
    local word_under_cursor = vim.fn.expand("<cword>")
    vim.cmd("Rg "..word_under_cursor)
end

function lsp_key_bindings(client, bufnr)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0}) -- 'gd' go to definition
        vim.keymap.set("n", "gi", vim.lsp.buf.hover, {buffer=bufnr}) -- 'gi' go to info
        vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer=bufnr}) -- 'gr' go rename
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0}) -- 'ca' code-action
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer=0})
end

local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
    on_attach = lsp_key_bindings
}

lspconfig.sourcekit.setup {
    on_attach = lsp_key_bindings,
    filetypes = { "swift", "objective-c", "objective-cpp"}
}

lspconfig.gopls.setup {
    on_attach = lsp_key_bindings
}

lspconfig.csharp_ls.setup {
    cmd = { "/Users/marcomagdy/.dotnet/tools/csharp-ls" },
    on_attach = lsp_key_bindings
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        focusable = false,
        style = "minimal",
        border = "rounded",
    }
)

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
vim.keymap.set("n", "<leader>f", find_under_cursor)

-- Disable tabs as spaces for go files
vim.api.nvim_create_autocmd({"BufEnter", "BufLeave"}, {
  pattern = {"*.go"},
  callback = function(args)
      if args.event == "BufEnter" then
          vim.cmd("set noexpandtab") -- disable tabs as spaces in go files
      elseif  args.event == "BufLeave" then
          vim.cmd("set expandtab") -- enable tabs again
      end
  end
})
