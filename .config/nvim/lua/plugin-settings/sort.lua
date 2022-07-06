local M = {}

M.config = function()
    local whichkey = require('which-key')

    local keys = {
        S = {'<cmd>Sort<cr>', 'Sort {motion}'},
    }
    local surroundings = {'\'', '"', '(', ')', '[', ']', '{', '}', '`'}
    for _, char in ipairs(surroundings) do
        keys['S' .. char] = {'vi' .. char .. '<esc><cmd>Sort<cr>', 'Sort in ' .. char}
    end

    whichkey.register(keys, {prefix = 'g'})

    whichkey.register({
        S = {'<esc><cmd>Sort<cr>', 'Sort'},
    }, {prefix = 'g', mode = 'v'})
end

return M
