local M = {}

M.config = function()
    local telescope = require('telescope')
    local whichkey = require('which-key')

    telescope.load_extension('arglist')

    whichkey.register({
        fa = {':Telescope arglist window<CR>', 'Arglist window'},
        fA = {':Telescope arglist global<CR>', 'Arglist global'},
    }, {prefix = '<leader>'})
end

return M
