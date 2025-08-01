local function get_arguments()
    return coroutine.create(function(dap_run_co)
        local args = {}
        vim.ui.input({ prompt = "Args: " }, function(input)
            args = vim.split(input or "", " ")
            coroutine.resume(dap_run_co, args)
        end)
    end)
end

local function get_build_flags(config)
    return coroutine.create(function(dap_run_co)
        local build_flags = config.build_flags
        vim.ui.input({ prompt = "Build Flags: " }, function(input)
            build_flags = vim.split(input or "", " ")
            coroutine.resume(dap_run_co, build_flags)
        end)
    end)
end

local function filtered_pick_process()
    local opts = {}
    vim.ui.input(
        { prompt = "Search by process name (lua pattern), or hit enter to select from the process list: " },
        function(input)
            opts["filter"] = input or ""
        end
    )
    return require("dap.utils").pick_process(opts)
end

local dap = require("dap")
if not dap.adapters["go"] then
    require("dap").adapters["go"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "dlv",
            args = {},
            detached = true,
            cwd = "${workspaceFolder}",
        },
    }
end

for _, language in ipairs({ "go" }) do
    if not dap.configurations[language] then
        dap.configurations[language] = {
            {
                type = "go",
                name = "Debug",
                request = "launch",
                program = "${file}",
                outputMode = "remote",
            },
            {
                type = "go",
                name = "Debug (Arguments)",
                request = "launch",
                program = "${file}",
                args = get_arguments,
                outputMode = "remote",
            },
            {
                type = "go",
                name = "Debug (Arguments & Build Flags)",
                request = "launch",
                program = "${file}",
                args = get_arguments,
                buildFlags = get_build_flags,
                outputMode = "remote",
            },
            {
                type = "go",
                name = "Debug Package",
                request = "launch",
                program = "${fileDirname}",
                outputMode = "remote",
            },
            {
                type = "go",
                name = "Attach",
                mode = "local",
                request = "attach",
                processId = filtered_pick_process,
            },
            {
                type = "go",
                name = "Debug test",
                request = "launch",
                mode = "test",
                program = "${file}",
                outputMode = "remote",
            },
            {
                type = "go",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}",
                outputMode = "remote",
            },
        }
    end
end
