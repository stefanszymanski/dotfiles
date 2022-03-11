local M = {}

M.config = function()
    local whichkey = require('which-key')

    whichkey.register({
        I = {':Telescope symbols<cr>', 'Insert symbol'}
    }, {prefix = 'g'})
end

return M
