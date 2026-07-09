return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        require("dapui").setup()

        local dap, dapui = require(".config.nvim.lua.the-real-night.plugins.code-execution-and-debugging.dap-debugger"),
            require("dapui")

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end

        vim.keymap.set('n', '<leader>ui', require 'dapui'.toggle)
    end
}
