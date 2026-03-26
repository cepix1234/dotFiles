return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false,                      -- neo-tree will lazily load itself
        config = function()
            require("neo-tree").setup({
                ---...other options
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                    },
                    window = {
                        mappings = {
                            -- Make the mapping anything you want
                            ["<C-d>A"] = "easyItem",
                            ["<C-d>SA"] = "easyNew",
                        },
                    },
                    commands = {
                        ["easyItem"] = function(state)
                            local node = state.tree:get_node()
                            local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
                            require("easy-dotnet").create_new_item(path, function()
                                require("neo-tree.sources.manager").refresh(state.name)
                            end)
                        end,
                        ["easyNew"] = function()
                            require("easy-dotnet").new()
                        end
                    }
                },
            })
            vim.keymap.set("n", "<leader>nf", "<cmd>Neotree reveal<cr>")
        end,
    }
}
