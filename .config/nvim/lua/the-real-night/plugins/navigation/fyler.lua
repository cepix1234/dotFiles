vim.pack.add({
    'https://github.com/FylerOrg/fyler.nvim'
})

local fyler = require("fyler")
fyler.setup({
    -- Whether to skip confirmation for "simple" mutations. A simple mutation
    -- follows: copy <= 1 and create <= 5 and delete <= 0 and move <= 1
    auto_confirm_simple_mutation = false,
    -- Restricts cursor from moving outside editable region
    bound_cursor = true,
    -- Buffer-local options applied to the finder buffer
    -- (see: nvim_set_option_value)
    buf_opts = {},
    -- Follow current file
    follow_current_file = true,
    -- Table of extensions to enable (e.g., 'git', 'trash', 'watcher')
    extensions = {},
    -- Event hooks for custom behavior (on_highlight, on_delete, on_rename)
    hooks = {},
    -- External integrations (e.g., icon provider)
    integrations = { icon = 'nvim_web_devicons' },
    -- Window-local options applied to the finder window
    -- (see: nvim_set_option_value)
    win_opts = {},
    -- Buffer kind to use globally.
    kind = 'floating',
    -- Per-kind preset overrides. Each preset can contain mappings,
    -- buf_opts, win_opts, and any window layout fields
    kind_presets = {
        floating = {
            -- Border style (see: :h winborder)
            border = 'single',
            -- Size of buffer:
            -- - string with '%' for relative (e.g. '70%')
            -- - number for absolute
            height = '80%',
            mappings = {
                n = {
                    ['<CR>'] = {
                        action = 'select',
                        args = { close = true, pick = false },
                    },
                },
            },
            width = '60%',
            -- Horizontal alignment: 'start' | 'center' | 'end'
            col = 'center',
            -- Vertical alignment: 'start' | 'center' | 'end'
            row = 'center',
        },
        replace = {
            mappings = {
                n = {
                    ['<CR>'] = {
                        action = 'select',
                        args = { close = true, pick = false },
                    },
                },
            },
        },
        split_above = { height = '50%' },
        split_above_all = { height = '50%' },
        split_below = { height = '50%' },
        split_below_all = { height = '50%' },
        split_left = { width = '25%' },
        split_left_most = { width = '25%' },
        split_right = { width = '25%' },
        split_right_most = { width = '25%' },
    },
    -- Key mappings organized by mode (see: fyler.Mapping)
    mappings = {
        n = {
            ['-'] = {
                action = 'visit',
                args = { parent = true },
            },
            ['.'] = {
                action = 'visit',
                args = { cursor = true },
            },
            ['<BS>'] = {
                action = 'shrink',
                args = { parent = true },
            },
            ['<C-R>'] = {
                action = 'refresh',
                args = { recursive = true, force = true },
            },
            ['<C-S>'] = {
                action = 'select',
                args = { split = true },
            },
            ['<C-T>'] = {
                action = 'select',
                args = { tabedit = true },
            },
            ['<C-V>'] = {
                action = 'select',
                args = { vsplit = true },
            },
            ['<CR>'] = {
                action = 'select',
                args = { pick = true },
            },
            ['='] = {
                action = 'visit',
            },
            ['g.'] = {
                action = 'toggle_ui',
                args = { 'hidden_items' },
            },
            ['gi'] = {
                action = 'toggle_ui',
                args = { 'indent_guides' },
            },
            ['q'] = {
                action = 'close',
            },
        },
    },
    -- UI configuration
    ui = {
        hidden_items = {
            -- Toggleable pre-defined switches (e.g. 'dotfiles' to hide files).
            switches = { 'dotfiles' },
            -- Toggleable patterns (Lua patterns matched against the full path).
            patterns = {},
            -- Always visible items matching these patterns, even if they would
            -- normally be hidden.
            always_visible = {},
            -- Always hide items matching these patterns, even if they would
            -- normally be visible.
            always_hidden = {},
        },
        -- Whether to draw indent guides at each depth level.
        indent_guides = true,
    },
})
-- You can map this to a key
vim.keymap.set("n", "<leader>pd", fyler.open, { desc = "Fyler.nvim - Open" })
