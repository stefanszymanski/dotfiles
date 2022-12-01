local M = {}

M.config = function()
    local legendary = require('legendary')
    local tmux = require('tmux')

    tmux.setup {
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

    legendary.bind_keymaps {
        {'<C-h>', tmux.move_left, description =     'Move to left window'},
        {'<C-l>', tmux.move_right, description =    'Move to right window'},
        {'<C-j>', tmux.move_bottom, description =   'Move to bottom window'},
        {'<C-k>', tmux.move_top, description =      'Move to top window'},

        -- {'<M-h>', tmux.resize_left, description =   'Resize to the left'},
        -- {'<M-l>', tmux.resize_right, description =  'Resize to the right'},
        -- {'<M-j>', tmux.resize_bottom, description = 'Resize to the bottom'},
        -- {'<M-k>', tmux.resize_top, description =    'Resize to the top'},
    }
end

return M
