vim.pack.add({
    "https://github.com/zk-org/zk-nvim"
})


local zk = require("zk")
local commands = require("zk.commands")
local float = require("the-real-night.plugins.misc.helpers.zk_helper")

-- Pick existing note(s) → open in float
commands.add("ZkFloatNotes", function(options)
    options = vim.tbl_extend("force", { sort = { "modified" } }, options or {})
    zk.index({ force = true }, function() end)
    zk.pick_notes(options, { title = "Zk Notes", multi_select = false }, function(note)
        float.open(note.absPath)
    end)
end)

-- Create a new note → open in float
commands.add("ZkFloatNew", function(options)
    require("zk.api").new(nil, options or {}, function(err, res)
        assert(not err, tostring(err))
        float.open(res.path)
    end)
end)

vim.keymap.set("n", "<leader>zo", "<cmd>ZkFloatNotes<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>ZkFloatNew { title = vim.fn.input('Title: ') }<CR>")

zk.setup({
    picker = "telescope"
})
