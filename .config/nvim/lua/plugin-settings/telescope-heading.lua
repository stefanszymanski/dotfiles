local M = {}

M.config = function()
    local telescope = require('telescope')
    local whichkey = require('which-key')

    telescope.load_extension('heading')

    whichkey.register({
        fh = {':Telescope heading<cr>', 'Headings in current buffer'},
    }, {prefix = '<leader>'})
end

return M
