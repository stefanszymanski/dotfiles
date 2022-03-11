local M = {}

M.config = function()
    local iswap = require('iswap')
    local whichkey = require('which-key')

    iswap.setup {
        keys = 'asdfghjkl',
        autoswap = true,
    }

    whichkey.register({
        s = { ':ISwapWith<cr>', 'Swap this' },
        ['<C-s>'] = { ':ISwap<cr>', 'Swap' }
    }, { prefix = 'g' })
end

return M
