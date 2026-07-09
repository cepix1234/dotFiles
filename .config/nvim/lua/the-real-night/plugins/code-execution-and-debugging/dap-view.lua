vim.pack.add({
    "https://github.com/igorlfs/nvim-dap-view"
})

require("dap-view").setup({
    windows = {
        size = 0.25,
        position = "below",
        terminal = {
            size = 0.5,
            position = "left",
            -- List of debug adapters for which the terminal should be ALWAYS hidden
            -- Can also be set to "true" to never show the terminal
            hide = false,
        },
    },
    virtual_text = {
        enabled = true,
    },
    auto_toggle = "keep_terminal"
})

vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap-view').hover()
end)
