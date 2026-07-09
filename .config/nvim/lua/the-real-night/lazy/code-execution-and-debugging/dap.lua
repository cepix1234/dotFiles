return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("the-real-night.lazy.code-execution-and-debugging.dap.node")
            require("the-real-night.lazy.code-execution-and-debugging.dap.go")
            require("the-real-night.lazy.code-execution-and-debugging.dap.dotNet")
            require("the-real-night.lazy.code-execution-and-debugging.dap.cpp")
            vim.keymap.set('n', '<F5>',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .continue() end)
            vim.keymap.set('n', '<F10>',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .step_over() end)
            vim.keymap.set('n', '<F11>',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .step_into() end)
            vim.keymap.set('n', '<F12>',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .step_out() end)
            vim.keymap.set('n', '<Leader>b',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>B',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .set_breakpoint() end)
            vim.keymap.set('n', '<Leader>lp',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set('n', '<Leader>dr',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .repl.open() end)
            vim.keymap.set('n', '<Leader>dl',
                function() require('.config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger')
                        .run_last() end)
            vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end)
            vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
                require('dap.ui.widgets').preview()
            end)
            vim.keymap.set('n', '<Leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end)
            vim.keymap.set('n', '<Leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end)
        end,
    }
}
