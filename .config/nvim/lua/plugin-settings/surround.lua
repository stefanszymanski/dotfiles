local M = {}

M.config = function()
    local whichkey = require('which-key')

    whichkey.register({
        s = 'Surround {motion} with {char}',
        S = 'Surround {motion} with {char} and wrap',
        ss = 'Surround line with {char}',
        Ss = 'Surround line with {char} and wrap',
    }, {prefix = 'y'})

    whichkey.register({
        s = 'Change surrounding {char} to {char}',
        S = 'Change surrounding {char} to {char} and wrap',
    }, {prefix = 'c'})

    whichkey.register({
        s = 'Delete surrounding {char}',
    }, {prefix = 'd'})

    whichkey.register({
        S = 'Surround with {char} and wrap',
    }, {prefix = 'g', mode = 'v'})
end

return M
