local M = {}

M.config = function()
    local whichkey = require('which-key')

    whichkey.register({
        bd = {':BufDel<cr>', 'Delete current'}
    }, {prefix = '<leader>'})
end

return M
