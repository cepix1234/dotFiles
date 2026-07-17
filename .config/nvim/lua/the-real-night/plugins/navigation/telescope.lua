vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
require('telescope').setup({
    defaults = {
        winblend = 15,
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
        mappings = {
            n = {
                ["dd"] = actions.delete_buffer,
            },
        }
    }
})

vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>pws', function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word, cwd = vim.fn.getcwd() })
end)

vim.keymap.set('n', '<leader>pWs', function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word, cwd = vim.fn.getcwd() })
end)

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > "), cwd = vim.fn.getcwd() })
end)


vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, silent = true })
