local M = {}

M.config = function()
    local dapui = require('dapui')
    local whichkey = require('which-key')

    dapui.setup {
        layouts = {
            {
                elements = {
                    { id = 'scopes', size = 0.45 },
                    { id = 'watches', size = 0.2 },
                    { id = 'breakpoints', size = 0.15 },
                    { id = 'stacks', size = 0.20 },
                },
                size = 100,
                position = 'right'
            }
        }
    }

    local options = {
        enter = true
    }

    whichkey.register({
        xu = { function() dapui.toggle('sidebar') end, 'Toggle UI' },
        xe = {
            name = 'Open in floating window',
            s = { function() dapui.float_element('scopes', options) end, 'Show scopes' },
            w = { function() dapui.float_element('watches', options) end, 'Show watches' },
            b = { function() dapui.float_element('breakpoints', options) end, 'Show breakpoints' },
            t = { function() dapui.float_element('stacks', options) end, 'Show stacks' },
        }
    }, { prefix = '<leader>' })
end

return M
