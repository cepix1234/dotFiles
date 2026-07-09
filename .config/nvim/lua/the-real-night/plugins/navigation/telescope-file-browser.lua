vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-file-browser.nvim"
})

local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

local easyItem = function(prompt_bufnr)
    local entry = actions_state.get_selected_entry()
    if not entry then
        return
    end

    local path

    if entry.Path and entry.Path:is_dir() then
        path = entry.Path:absolute()
    else
        path = vim.fs.dirname(entry.path or entry.value or entry.filename)
    end

    require("easy-dotnet").create_new_item(path, function()
        actions.close(prompt_bufnr)

        require("telescope").extensions.file_browser.file_browser({
            path = path,
            select_buffer = true,
        })
    end)
end

local easyNew = function()
    require("easy-dotnet").new()
end

local copyFilePath = function(state)
    local entry = actions_state.get_selected_entry()
    if not entry then
        return
    end

    local filepath = entry.path or entry.value or entry.filename
    local filename = vim.fs.basename(filepath)
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

require('telescope').setup({
    extensions = {
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            select_buffer = true,
            hidden = true,
            auto_depth = true,
            depth = 1,
            mappings = {
                ["n"] = {
                    ["<C-d>A"] = easyItem,
                    ["<C-d>SA"] = easyNew,
                    ["Y"] = copyFilePath
                },
            },
        },
    },
})

require("telescope").load_extension "file_browser"
vim.keymap.set("n", "<space>pf", function()
    require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" })
end)
