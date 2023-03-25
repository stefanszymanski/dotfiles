local M = {}

M.config = function()
    local dressing = require('dressing')

    dressing.setup {
        input = {
            win_options = {
                -- disable transparency
                winblend = 100
            }
        },
    }
end

return M
