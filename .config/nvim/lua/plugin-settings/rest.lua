local M = {}

M.config = function()
    local rest = require('rest-nvim')
    local whichkey = require('which-key')

    rest.setup {}

    whichkey.register({
        h = {
            name = 'HTTP Request',
            h = {'<Plug>RestNvim',        'Run HTTP request'},
            p = {'<Plug>RestNvimPreview', 'Preview HTTP request'},
            r = {'<Plug>RestNvimLast',    'Rerun latest HTTP request'},
        }
    }, { prefix = '<leader>' })
end

return M
