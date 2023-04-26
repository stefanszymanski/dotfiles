local M = {
    'aserowy/tmux.nvim',
}

M.keys = function()
    local mode = { 'n', 'v', 't' }
    return {
        { '<C-h>', function() require('tmux').move_left() end, desc = 'Move to left window', mode = mode },
        { '<C-l>', function() require('tmux').move_right() end, desc = 'Move to right window', mode = mode },
        { '<C-j>', function() require('tmux').move_bottom() end, desc = 'Move to bottom window', mode = mode },
        { '<C-k>', function() require('tmux').move_top() end, desc = 'Move to top window', mode = mode },
        { '<M-h>', function() require('tmux').resize_left() end, desc = 'Resize to left window', mode = mode },
        { '<M-l>', function() require('tmux').resize_right() end, desc = 'Resize to right window', mode = mode },
        { '<M-j>', function() require('tmux').resize_bottom() end, desc = 'Resize to bottom window', mode = mode },
        { '<M-k>', function() require('tmux').resize_top() end, desc = 'Resize to top window', mode = mode },
    }
end

M.config = function()
    require('tmux').setup {
        navigation = {
            cycle_navigation = false,
        },
        resize = {
            resize_step_x = 10,
            resize_step_y = 10,
        },
        copy_sync = {
            enable = false,
        }
    }
end

return M
