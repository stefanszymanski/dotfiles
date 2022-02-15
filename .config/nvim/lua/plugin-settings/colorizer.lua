local M = {}

M.config = function()
    local colorizer = require('colorizer')
    local whichkey = require('which-key')

    colorizer.setup{}

    whichkey.register({oC = {'<cmd>ColorizerToggle<cr>',           'Colorizer'}}, {prefix = 'y'})
    whichkey.register({oC = {'<cmd>ColorizerAttachToBuffer<cr>',   'Colorizer'}}, {prefix = '['})
    whichkey.register({oC = {'<cmd>ColorizerDetachFromBuffer<cr>', 'Colorizer'}}, {prefix = ']'})
end

return M
