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

--local arrayUtils = require "the-real-night.utils.array"
--
--local pkgs_candidates = {}
--table.insert(pkgs_candidates, "csharp-language-server")
--table.insert(pkgs_candidates, "eslint-lsp")
--table.insert(pkgs_candidates, "gopls")
--table.insert(pkgs_candidates, "js-debug-adapter")
--table.insert(pkgs_candidates, "json-lsp")
--table.insert(pkgs_candidates, "lua-language-server")
--table.insert(pkgs_candidates, "marksman")
--table.insert(pkgs_candidates, "powershell-editor-services")
--table.insert(pkgs_candidates, "python-lsp-server")
--table.insert(pkgs_candidates, "rust-analyzer")
--table.insert(pkgs_candidates, "typescript-language-server")
--table.insert(pkgs_candidates, "netcoredbg")
--table.insert(pkgs_candidates, "go-debug-adapter")
--table.insert(pkgs_candidates, "cpptools")
--
---- only install what is not already installed
--local Regestry = require("mason-registry")
--local instaled_pkgs = Regestry.get_installed_package_names()
--local pkgs_to_install = {}
--for i, v in ipairs(pkgs_candidates) do
--    if not arrayUtils.has_value(instaled_pkgs, v) then
--        table.insert(pkgs_to_install, v)
--    end
--end
--
--text = ""
--for i, v in ipairs(pkgs_to_install) do
--    text = text .. ", " .. v
--end
--vim.notify('MASON TO INTALL:' .. text)
--local Command = require "mason.api.command"
--if not vim.tbl_isempty(pkgs_to_install) then
--    Command.MasonInstall(pkgs_to_install)
--end
