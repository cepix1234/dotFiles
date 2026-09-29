vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/stevearc/overseer.nvim",
    { src = "https://github.com/polarmutex/git-worktree.nvim", version = "2.1.0" },
})
local rootDir = vim.fn.getcwd() .. '/';

vim.g.git_worktree_log_level = "trace"
require('telescope').load_extension('git_worktree')
local git_worktree = require('git-worktree')

local Hooks = require 'git-worktree.hooks'
local config = require('git-worktree.config')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

Hooks.register(Hooks.type.DELETE, function()
    vim.cmd(config.update_on_change_command)
end)

Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
    vim.notify('Moved:' .. prev_path .. '  ~>  ' .. path)
    update_on_switch(path, prev_path)
    local tmuxUtil = require "the-real-night.tmux-setup"
    tmuxUtil.dir_change(path)
end)

local function slugify_branch(name)
    name = vim.trim(name):lower()
    name = name:gsub('%s+', '-')                  -- spaces -> dashes
    name = name:gsub('[^%w%-%./_]', '')           -- drop chars git dislikes
    name = name:gsub('%-+', '-')                  -- collapse repeated dashes
    name = name:gsub('/%-', '/'):gsub('%-/', '/') -- no dashes around slashes
    name = name:gsub('^%-', ''):gsub('%-$', '')
    return name
end

local function make_worktree(branch)
    local default_path = rootDir .. branch
    vim.ui.input({ prompt = 'Path > ', default = default_path }, function(p)
        if not p or p == '' then return end
        git_worktree.create_worktree(p, branch, 'origin')
    end)
end

local switch_worktree = function()
    require('telescope').extensions.git_worktree.git_worktree()
end

local create_worktree = function()
    require('telescope.builtin').git_branches({
        prompt_title = 'Create worktree  (<CR> existing, <C-a> new from prompt)',
        attach_mappings = function(prompt_bufnr, map)
            -- <CR>: existing local/remote branch
            actions.select_default:replace(function()
                local selected_entry = action_state.get_selected_entry()
                local current_line = action_state.get_current_line()

                actions.close(prompt_bufnr)

                local branch = selected_entry ~= nil and
                    selected_entry.value or current_line

                if branch == nil then
                    return
                end

                make_worktree(slugify_branch(branch))
            end)

            return true -- keep telescope's other default mappings
        end,
    })
end

vim.keymap.set('n', '<leader>wG', create_worktree)
vim.keymap.set('n', '<leader>wg', switch_worktree)
