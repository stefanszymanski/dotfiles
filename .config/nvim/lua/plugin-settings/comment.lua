local M = {}

M.config = function()
    local comment = require('Comment')
    local whichkey = require('which-key')

    comment.setup{}

    whichkey.register({
        c =         'Toggle line comment for {motion}',
        cc =        'Toggle line comment for line',
        b =         'Toggle block comment for {motion}',
        bc =        'Toggle block comment for line',
    } , {prefix = 'g', mode = 'n'})

    whichkey.register({
        c =         'Toggle line comment',
        b =         'Toggle block comment',
    } , {prefix = 'g', mode = 'v'})
end

return M
