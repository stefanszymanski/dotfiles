local M = {}

M.config = function()
    local telescope = require('telescope')
    local whichkey = require('which-key')

    telescope.load_extension('arglist')

    whichkey.register({
        fa = {':Telescope arglist window<cr>', 'Arglist window'},
        fA = {':Telescope arglist global<cr>', 'Arglist global'},
    }, {prefix = '<leader>'})
end

return M
