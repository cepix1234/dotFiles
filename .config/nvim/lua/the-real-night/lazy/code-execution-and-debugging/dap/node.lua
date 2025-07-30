local dap = require("dap")
if not dap.adapters["pwa-node"] then
    require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "js-debug-adapter",
            args = { "${port}" },
        },
    }
end
if not dap.adapters["node"] then
    dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
            config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
            nativeAdapter(cb, config)
        else
            cb(nativeAdapter)
        end
    end
end

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
    if not dap.configurations[language] then
        dap.configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
            },
            {
                type = 'pwa-node',
                request = 'attach',
                name = 'Atach 9229',
                port = 9229,
                cwd = "${workspaceFolder}",
            }
        }
    end
end
