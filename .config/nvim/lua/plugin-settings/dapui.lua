local M = {}

M.config = function()
    local dapui = require('dapui')
    local whichkey = require('which-key')

    dapui.setup {
        sidebar = {
            elements = {
                {id = 'scopes', size = 0.65},
                {id = 'breakpoints', size = 0.15},
                {id = 'stacks', size = 0.20},
            },
            size = 100,
            position = 'right'
        }
    }

    whichkey.register({
        dd = {function() dapui.toggle('sidebar') end,                                    'Toggle UI'},
    }, {prefix = '<leader>'})
end

return M

