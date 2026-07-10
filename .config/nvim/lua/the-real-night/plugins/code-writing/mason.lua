vim.pack.add({
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
})

require('mason-tool-installer').setup({
    ensure_installed = {
        "csharp-language-server",
        "eslint-lsp",
        "gopls",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "powershell-editor-services",
        "python-lsp-server",
        "rust-analyzer",
        "typescript-language-server",
        "netcoredbg",
        "go-debug-adapter",
        "cpptools",
    },
})

require('mason-lspconfig').setup({
    automatic_enable = false,
})
