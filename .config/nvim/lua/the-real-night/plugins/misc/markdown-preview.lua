vim.pack.add({
    "https://github.com/iamcco/markdown-preview.nvim",
})

vim.g.mkdp_filetypes = { "markdown" }
vim.fn["mkdp#util#install"]()
vim.keymap.set("n", "<leader>mp", '::MarkdownPreviewToggle<cr>', { silent = false })
