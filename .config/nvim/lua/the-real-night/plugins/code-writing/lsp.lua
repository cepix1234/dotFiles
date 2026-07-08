vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/neovim/nvim-lspconfig",
})

require("mason").setup()
require("fidget").setup({})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.1",
            },
            diagnostics = {
                globals = {
                    "bit",
                    "vim",
                    "it",
                    "describe",
                    "before_each",
                    "after_each",
                },
            },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "ts_ls",
    "eslint",
    "jsonls",
    "pylsp",
    "csharp_ls",
    "powershell_es"
})

vim.diagnostic.config({
    virtual_text = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gs", vim.lsp.buf.rename, "Rename")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, "Get code actions")
        map("n", "K", vim.lsp.buf.hover, "LSP hover")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    end,
})
