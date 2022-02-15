local M = {}

M.config = function()
    local whichkey = require('which-key')

    local keys = {
        s = {'<cmd>Sort<cr>', 'Sort {motion}'},
    }
    local surroundings = {'\'', '"', '(', ')', '[', ']', '{', '}', '`'}
    for _, char in ipairs(surroundings) do
        keys['s' .. char] = {'vi' .. char .. '<esc><cmd>Sort<cr>', 'Sort in ' .. char}
    end

    whichkey.register(keys, {prefix = 'g'})

    whichkey.register({
        s = {'<esc><cmd>Sort<cr>', 'Sort'},
    }, {prefix = 'g', mode = 'v'})
end

return M
