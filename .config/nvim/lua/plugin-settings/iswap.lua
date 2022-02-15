local M = {}

M.config = function()
    local iswap = require('iswap')
    local whichkey = require('which-key')

    iswap.setup {
        keys = 'asdfghjkl',
        autoswap = true,
    }

    whichkey.register({
        ['<leader>'] = {
            s = {':ISwapWith<cr>', 'Swap this'},
            S = {':ISwap<cr>',     'Swap'}
        }
    }, {prefix = '<leader>'})
end

return M
