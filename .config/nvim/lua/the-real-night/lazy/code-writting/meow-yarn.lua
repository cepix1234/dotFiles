return {
    "retran/meow.yarn.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        require("meow.yarn").setup({
            window = {
                width = 0.8,
                height = 0.85,
                border = "rounded",
                preview_height_ratio = 0.35,
            },
            icons = {
                loading = "",
                placeholder = "",
                animation_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            },
            mappings = {
                jump = "<CR>",
                toggle = "<Tab>",
                expand = "l",
                expand_alt = "<Right>",
                collapse = "h",
                collapse_alt = "<Left>",
                quit = "q",
            },
            expand_depth = 3,
            preview_context_lines = 10,
            animation_speed = 100,
            hierarchies = {
                type_hierarchy = {
                    icons = {
                        class = "󰌗",
                        struct = "󰙅",
                        interface = "󰌆",
                        default = "",
                    },
                },
                call_hierarchy = {
                    icons = {
                        method = "󰆧",
                        func = "󰊕",
                        variable = "",
                        default = "",
                    },
                },
            },
        })

        -- Using lua functions
        vim.keymap.set("n", "<leader>yt", function() require("meow.yarn").open_tree("type_hierarchy", "supertypes") end,
            { desc = "Yarn: Type Hierarchy (Super)" })
        vim.keymap.set("n", "<leader>yT", function() require("meow.yarn").open_tree("type_hierarchy", "subtypes") end,
            { desc = "Yarn: Type Hierarchy (Sub)" })
        vim.keymap.set("n", "<leader>yc", function() require("meow.yarn").open_tree("call_hierarchy", "callers") end,
            { desc = "Yarn: Call Hierarchy (Callers)" })
        vim.keymap.set("n", "<leader>yC", function() require("meow.yarn").open_tree("call_hierarchy", "callees") end,
            { desc = "Yarn: Call Hierarchy (Callees)" })
    end,
}
