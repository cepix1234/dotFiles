return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            hijack_netrw = false,
            disable_netrw = false,
            view = {
                width = {
                    min = 30,
                    max = -1
                }
            },
            hijack_directories = {
                enable = false,
            }
        }
        local api = require "nvim-tree.api"
        vim.keymap.set('n', '<leader>nf', api.tree.find_file)
        vim.keymap.set('n', '<leader>nt', api.tree.toggle)

        local events = require "nvim-tree.events"
        events.subscribe(api.events.Event.Ready, function()
            local tmuxUtil = require "the-real-night.tmux-setup"
            tmuxUtil.dir_change(vim.fn.getcwd())
        end)
    end,
}
