local Job = require("plenary.job")
local cwd = vim.fn.getcwd()
local dirChangeCommand = 'cd'
local terminalClearCommand = 'clear'

local sessionStatus = os.getenv("TMUX")
if sessionStatus == nil or sessionStatus == "" then
    vim.ui.input({ prompt = "No TMUX session detected. Run Neovim within a TMUX session. EXIT neovim." },
        function() os.exit() end)
end

local sessionName = vim.fn.system({ "tmux", "display-message", "-p", "'#S'" })
local sessionId = string.gsub(string.gsub(sessionName, "\n", ""), "^%p(.*)%p$", "%1")

local lazygitWindowId = string.format("%s:%s.%s", sessionId, 2, 1)
local terminalTwoWindowId = string.format("%s:%s.%s", sessionId, 3, 1)
local terminalThreWindowId = string.format("%s:%s.%s", sessionId, 4, 1)
local lazyGitInit = false

local tmuxWindows = Job:new({ 'tmux', 'list-windows', cwd = cwd }):sync()
local sendKeys = function(command, windowId)
    vim.notify('sending keys: ' .. command .. '   ;to:' .. windowId)
    Job:new({ 'tmux', 'send-keys', '-t', windowId, command, 'Enter', cwd = cwd }):sync()
end

local dir_change_function = function(dir)
    vim.notify('changing to:' .. dir)
    local command = string.format("%s %s", dirChangeCommand, dir)
    local clearCommand = string.format("%s", terminalClearCommand)
    sendKeys(command, terminalTwoWindowId)
    sendKeys(clearCommand, terminalTwoWindowId)
    sendKeys(command, terminalThreWindowId)
    sendKeys(clearCommand, terminalThreWindowId)

    if lazyGitInit == true then
        sendKeys("q", lazygitWindowId)
        sendKeys(clearCommand, lazygitWindowId)
    end
    sendKeys(command, lazygitWindowId)
    sendKeys("lazygit", lazygitWindowId)
    lazyGitInit = true
end

if #tmuxWindows == 1 then
    Job:new({ 'tmux', 'rename-window', '-t', '1', 'main:NVIM', cwd = cwd }):sync()
    Job:new({ 'tmux', 'new-window', '-n', 'lazygit', cwd = cwd }):sync()
    Job:new({ 'tmux', 'new-window', '-n', 'terminal', cwd = cwd }):sync()
    Job:new({ 'tmux', 'new-window', '-n', 'terminal', cwd = cwd }):sync()
    Job:new({ 'tmux', 'select-window', '-t', '1', cwd = cwd }):sync()
end

return {
    dir_change = dir_change_function
}
