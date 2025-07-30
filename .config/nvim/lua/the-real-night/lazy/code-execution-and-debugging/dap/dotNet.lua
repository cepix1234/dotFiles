local dap = require("dap")
if not dap.adapters["coreclr"] then
    local Command = require "mason.api.command"
    require("dap").adapters["coreclr"] = {
        type = "executable",
        command = "netcoredbg",
        args = { '--interpreter=vscode' },
    }
end

for _, language in ipairs({ "cs" }) do
    if not dap.configurations[language] then
        dap.configurations[language] = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
            } }
    end
end
