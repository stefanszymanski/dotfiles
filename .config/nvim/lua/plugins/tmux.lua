local M = {
    'aserowy/tmux.nvim',
    keys = {
        { '<C-h>', function() require('tmux').move_left() end, desc = 'Move to left window' },
        { '<C-l>', function() require('tmux').move_right() end, desc = 'Move to right window' },
        { '<C-j>', function() require('tmux').move_bottom() end, desc = 'Move to bottom window' },
        { '<C-k>', function() require('tmux').move_top() end, desc = 'Move to top window' },
        { '<M-h>', function() require('tmux').resize_left() end, desc = 'Resize to left window' },
        { '<M-l>', function() require('tmux').resize_right() end, desc = 'Resize to right window' },
        { '<M-j>', function() require('tmux').resize_bottom() end, desc = 'Resize to bottom window' },
        { '<M-k>', function() require('tmux').resize_top() end, desc = 'Resize to top window' },
    }
}

M.config = function()
    require('tmux').setup {
        navigation = {
            cycle_navigation = false,
        },
        resize = {
            resize_step_x = 5,
            resize_step_y = 5,
        },
        copy_sync = {
            enable = false,
        }
    }
end

return M
