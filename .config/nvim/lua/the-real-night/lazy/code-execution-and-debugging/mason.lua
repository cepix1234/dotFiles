local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()

            local pkgs_candidates = {}
            table.insert(pkgs_candidates, "csharp-language-server")
            table.insert(pkgs_candidates, "eslint-lsp")
            table.insert(pkgs_candidates, "gopls")
            table.insert(pkgs_candidates, "js-debug-adapter")
            table.insert(pkgs_candidates, "json-lsp")
            table.insert(pkgs_candidates, "lua-language-server")
            table.insert(pkgs_candidates, "marksman")
            table.insert(pkgs_candidates, "powershell-editor-services")
            table.insert(pkgs_candidates, "python-lsp-server")
            table.insert(pkgs_candidates, "rust-analyzer")
            table.insert(pkgs_candidates, "typescript-language-server")
            table.insert(pkgs_candidates, "netcoredbg")
            table.insert(pkgs_candidates, "go-debug-adapter")
            table.insert(pkgs_candidates, "cpptools")

            -- only install what is not already installed
            local Regestry = require("mason-registry")
            local instaled_pkgs = Regestry.get_installed_package_names()
            local pkgs_to_install = {}
            for i, v in ipairs(pkgs_candidates) do
                if not has_value(instaled_pkgs, v) then
                    table.insert(pkgs_to_install, v)
                end
            end

            text = ""
            for i, v in ipairs(pkgs_to_install) do
                text = text .. ", " .. v
            end
            vim.notify('MASON TO INTALL:' .. text)
            local Command = require "mason.api.command"
            if not vim.tbl_isempty(pkgs_to_install) then
                Command.MasonInstall(pkgs_to_install)
            end
        end
    }
}
