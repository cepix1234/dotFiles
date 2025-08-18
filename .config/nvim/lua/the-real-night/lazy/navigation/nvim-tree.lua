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
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set('n', '<C-d>A', function()
            local node = api.tree.get_node_under_cursor()
            local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
            require("easy-dotnet").create_new_item(path)
        end, opts('Create file from dotnet template'))
    end,
}
