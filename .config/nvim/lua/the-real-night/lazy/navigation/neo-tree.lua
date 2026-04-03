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
                            ["Y"] = "copyFilePath"
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
                        end,
                        ["copyFilePath"] = function(state)
                            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
                            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
                            local node = state.tree:get_node()
                            local filepath = node:get_id()
                            local filename = node.name
                            local modify = vim.fn.fnamemodify

                            local results = {
                                filepath,
                                modify(filepath, ':.'),
                                modify(filepath, ':~'),
                                filename,
                                modify(filename, ':r'),
                                modify(filename, ':e'),
                            }

                            -- absolute path to clipboard
                            local i = vim.fn.inputlist({
                                'Choose to copy to clipboard:',
                                '1. Absolute path: ' .. results[1],
                                '2. Path relative to CWD: ' .. results[2],
                                '3. Path relative to HOME: ' .. results[3],
                                '4. Filename: ' .. results[4],
                                '5. Filename without extension: ' .. results[5],
                                '6. Extension of the filename: ' .. results[6],
                            })

                            if i > 0 then
                                local result = results[i]
                                if not result then return print('Invalid choice: ' .. i) end
                                vim.fn.setreg('"', result)
                                vim.notify('Copied: ' .. result)
                            end
                        end
                    }
                },
            })
            vim.keymap.set("n", "<leader>nf", "<cmd>Neotree reveal<cr>")
        end,
    }
}
