local dap = require(".config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger")
if not dap.adapters["llbd"] then
    require(".config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger").adapters["llbd"] = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
        name = "lldb",
    }
end

for _, language in ipairs({ "cpp", "c" }) do
    if not dap.configurations[language] then
        dap.configurations[language] = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input(
                        "Path to executable: ",
                        vim.fn.getcwd() .. "/",
                        "file"
                    )
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            },
            {
                -- If you get an "Operation not permitted" error using this, try disabling YAMA:
                --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                name = "Attach to process",
                type = "cpp", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
                request = "attach",
                pid = require("dap.utils").pick_process,
                args = {},
            },
        }
    end
end
