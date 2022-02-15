local M = {}

M.config = function()
    local hop = require('hop')
    local whichkey = require('which-key')

    hop.setup {}

    whichkey.register({
        W = {':HopWord<cr>', 'Hop to word'},
        l = {':HopChar1CurrentLine<cr>', 'Hop to {char} in current line'},
        L = {':HopLineStart<cr>', 'Hop to line'},
        ['1'] = {':HopChar1<cr>', 'Hop to {char}'},
        ['2'] = {':HopChar2<cr>', 'Hop to {char}{char}'},
    }, {prefix = 'g'})
end

return M
