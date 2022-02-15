local M = {}

M.config = function()
    local legendary = require('legendary')
    local whichkey = require('which-key')

    legendary.setup {}

    whichkey.register({
        fk = {':Legendary keymaps<cr>', 'Key bindings'}
    }, {prefix = '<leader>'})
end

return M
