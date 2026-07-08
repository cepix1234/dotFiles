return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        require('telescope').setup({
            extensions = {
                file_browser = {
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = false,
                    select_buffer = true,
                    hidden = true,
                    auto_depth = true,
                    depth = 10,
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
            },
        })
        require("telescope").load_extension "file_browser"
        vim.keymap.set("n", "<space>pf", function()
            require("telescope").extensions.file_browser.file_browser()
        end)
    end,
}
