local M = {}

M.config = function()
    local whichkey = require('which-key')

    whichkey.register({
        A = 'Show number conversions'
    }, {prefix = 'g'})
    whichkey.register({
        A = 'Show number conversions'
    }, {prefix = 'g', mode = 'v'})

    whichkey.register({
        r = {
            name = 'convert number',
            b = 'to binary',
            d = 'to decimal',
            o = 'to octal',
            x = 'to hexadecimal',
        },
    }, {prefix = 'c'})
end

return M
