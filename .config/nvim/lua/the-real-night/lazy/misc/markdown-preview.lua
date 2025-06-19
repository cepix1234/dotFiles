return
{
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
        vim.fn["mkdp#util#install"]()
        vim.keymap.set("n", "<leader>mp", '::MarkdownPreviewToggle<cr>', { silent = false })
    end,
}
