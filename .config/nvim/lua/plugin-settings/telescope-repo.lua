local M = {}

M.config = function()
    local telescope = require('telescope')
    local whichkey = require('which-key')

    telescope.load_extension('repo')

    whichkey.register({
        fp = {[[:lua require('telescope').extensions.repo.list{fd_opts = {'--exclude=.*/**', '--exclude=build/'}}<cr>]], 'Projects'},
    }, {prefix = '<leader>'})
end

return M
