local M = {}

M.config = function()
    local legendary = require('legendary')
    local whichkey = require('which-key')
    
    legendary.keymaps {
        {'<C-y>', description = 'Emmet'},
    }

    whichkey.register({
        name = 'Emmet',
        [','] = 'Expand abbreviation',
        ['/'] = 'Toggle comment',
        [';'] = 'Expand word',
        a = 'Anchorize URL',
        A = 'Anchorize summary',
        d = 'Balance tag inward',
        D = 'Balance tag outword',
        u = 'Update tag',
        n = 'Move next',
        N = 'Move previous',
        i = 'Image size',
        I = 'Image encode',
        j = 'Split join tag',
        k = 'Remove tag',
        m = 'Merge lines',
        c = 'Prettify code',
    }, {prefix = '<C-y>'})

    whichkey.register({
        name = 'Emmet',
        [','] = 'Wrap with abbreviation',
        c = 'Prettify code',
        d = 'Balance tag inward',
        D = 'Balance tag outword',
    }, {prefix = '<C-y>', mode = 'v'})
end

return M
