vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    'https://github.com/mikavilpas/yazi.nvim'
})

require("yazi").setup({
    -- Replace netrw when opening a directory (e.g. `nvim .`)
    open_for_directories = true,
})
