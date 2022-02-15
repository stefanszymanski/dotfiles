local M = {}

M.config = function()
    local whichkey = require('which-key')

    whichkey.register({
    g = {
        A = {':Git add %<cr>',                                     'Stage document'},
        r = {':Git reset HEAD %<cr>',                              'Reset document'},
        R = {':Git reset HEAD .<cr>',                              'Reset all'},
        x = {
            f = {':Git fetch --all<cr>',                                'Fetch'},
            c = {':Git commit<cr>',                                     'Commit'},
            p = {':Git pull<cr>',                                       'Pull'},
            u = {':Git push<cr>',                                       'Push'},
        }
    },
    }, {prefix = '<leader>'})
end

return M
