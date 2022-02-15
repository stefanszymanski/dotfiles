local M = {}

M.config = function()
    local sessionlens = require('session-lens')
    local telescope = require('telescope')
    local whichkey = require('which-key')

    sessionlens.setup {}
    telescope.load_extension('session-lens')

    whichkey.register({
        ss = {':SearchSession<cr>', 'List sessions'}
    }, {prefix = '<leader>'})
end

return M
