vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    'https://github.com/mikavilpas/yazi.nvim'
})

local function copyFilePath(config, context)
    local keybinding_helpers = require("yazi.keybinding_helpers")

    keybinding_helpers.select_current_file_and_close_yazi(config, {
        api = context.api,
        on_file_opened = function(filepath)
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
        end,
    })
end

local function easyItem(config, context)
    local keybinding_helpers = require("yazi.keybinding_helpers")

    keybinding_helpers.select_current_file_and_close_yazi(config, {
        api = context.api,
        on_file_opened = function(chosen_file)
            local dir = vim.fn.isdirectory(chosen_file) == 1 and chosen_file
                or vim.fs.dirname(chosen_file)

            require("easy-dotnet").create_new_item(dir, function(new_path)
                require("yazi").yazi({}, new_path or dir)
            end)
        end,
    })
end

local function easyNew()
    require("easy-dotnet.actions.new").new()
end

vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        require("yazi").setup({
            open_for_directories = true,
            set_keymappings_function = function(yazi_buffer, config, context)
                require("yazi.config").set_keymappings(yazi_buffer, config, context)

                vim.keymap.set({ "t" }, "Y", function()
                    copyFilePath(config, context)
                end, { buffer = yazi_buffer })

                vim.keymap.set({ "t" }, "<C-d>A", function()
                    easyItem(config, context)
                end, { buffer = yazi_buffer })

                vim.keymap.set({ "t" }, "<C-d>SA", function()
                    easyNew()
                end, { buffer = yazi_buffer })
            end,
        })
    end,
})

vim.keymap.set("n", "<space>pf", function()
    require("yazi").yazi()
end)
