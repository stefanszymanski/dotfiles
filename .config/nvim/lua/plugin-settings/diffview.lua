local M = {}

M.config = function()
    local diffview = require('diffview')
    local whichkey = require('which-key')

    diffview.setup{}

    whichkey.register({ gS = {'<cmd>DiffviewOpen<cr>', 'Status'}}, {prefix = '<leader>'})
    whichkey.register({ gh = {'<cmd>DiffviewFileHistory<cr>', 'Document history'}}, {prefix = '<leader>'})
end

return M
