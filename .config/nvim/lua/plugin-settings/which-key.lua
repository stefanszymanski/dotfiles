local M = {}

M.config = function()
    local whichkey = require('which-key')

    whichkey.setup {
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 30
            },
        },
        layout = {
            height = {min = 2, max = 12},
            align = 'center',
        },
        ignore_missing = false,
        show_help = false,
    }

    vim.o.timeoutlen = 200
end

return M
