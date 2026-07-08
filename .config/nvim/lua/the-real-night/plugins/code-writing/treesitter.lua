vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",

})

local treesitter = require('nvim-treesitter')
treesitter.install({ "c_sharp" }):wait(300000)

local treesitter_parser_config = require("nvim-treesitter.parsers")
treesitter_parser_config.templ = {
    install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
    },
}
treesitter_parser_config.powershell = {
    install_info = {
        url = "~/.config/nvim/lua/the-real-night/ts-parsers/tree-sitter-powershell/",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    },
    filetype = "ps1",
}

vim.treesitter.language.register("templ", "templ")

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        if args.match == "cs" or args.match == "csharp" or args.match == "bash" then
            vim.treesitter.start()
        end

        pcall(vim.treesitter.start)
    end,
})
