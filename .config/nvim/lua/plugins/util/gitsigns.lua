local config = require('gitsigns.config').config
local refresh = require('gitsigns.actions').refresh

local M = {}

M.set_diff = function(enabled)
    if enabled then
        print('Enable Git diff view')
    else
        print('Disable Git diff view')
    end
    config.numhl = enabled
    config.linehl = enabled
    config.show_deleted = enabled
    refresh()
end

M.enable_diff = function()
    M.set_diff(true)
end

M.disable_diff = function()
    M.set_diff(false)
end

M.toggle_diff = function()
    M.set_diff(not config.linehl)
end

return M
