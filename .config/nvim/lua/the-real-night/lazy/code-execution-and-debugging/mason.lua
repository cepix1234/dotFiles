return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            local pkgs_to_install = {}
            table.insert(pkgs_to_install, "js-debug-adapter")
            table.insert(pkgs_to_install, "csharp-language-server")
            table.insert(pkgs_to_install, "eslint-lsp")
            table.insert(pkgs_to_install, "gopls")
            table.insert(pkgs_to_install, "js-debug-adapter")
            table.insert(pkgs_to_install, "json-lsp")
            table.insert(pkgs_to_install, "lua-language-server")
            table.insert(pkgs_to_install, "marksman")
            table.insert(pkgs_to_install, "powershell-editor-services")
            table.insert(pkgs_to_install, "python-lsp-server")
            table.insert(pkgs_to_install, "rust-analyzer")
            table.insert(pkgs_to_install, "typescript-language-server")
            table.insert(pkgs_to_install, "netcoredbg")

            local Command = require "mason.api.command"
            if not vim.tbl_isempty(pkgs_to_install) then
                Command.MasonInstall(pkgs_to_install)
            end
        end
    }
}
