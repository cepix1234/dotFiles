vim.pack.add({
    "https://github.com/carlos-algms/agentic.nvim",
})

vim.keymap.set('n', '<leader>cd', function()
    require("agentic").toggle()
end)

vim.keymap.set({ 'n', 'v' }, '<leader>c`', function()
    require("agentic").new_session()
end)

vim.keymap.set('n', '<leader>c,', function()
    require("agentic").restore_session()
end)

vim.keymap.set('n', '<leader>cD', function()
    require("agentic").add_current_line_diagnostics()
end)

vim.keymap.set('n', '<leader>aD', function()
    require("agentic").add_buffer_diagnostics()
end)
