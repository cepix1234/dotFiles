local M = {}

function M.open(path)
    local buf = vim.fn.bufadd(path)
    vim.fn.bufload(buf)
    vim.bo[buf].buflisted = true

    local width           = math.floor(vim.o.columns * 0.8)
    local height          = math.floor(vim.o.lines * 0.8)

    local win             = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " " .. vim.fn.fnamemodify(path, ":t") .. " ",
        title_pos = "center",
    })

    -- q / <Esc> closes the float (buffer stays loaded)
    vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end,
        { buffer = buf, nowait = true })
    -- restore normal window options that "minimal" turns off
    vim.wo[win].number = true
    vim.wo[win].wrap = true
    return win
end

return M
