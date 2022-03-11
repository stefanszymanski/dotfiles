local M = {}

M.config = function()
    local legendary = require('legendary')

    vim.cmd [[
        let HiClear = 'f<bs><bs>'
    ]]

    legendary.bind_keymaps {
        {'f<cr>', description = 'Highlight word under cursor' },
        {'f<bs>', description = 'Remove highlighting word under cursor' },
        {'f<bs><bs>', description = 'Clear highlighting' },
        {'f<tab>', description = 'Open highlight find view' },
    }
end

return M
