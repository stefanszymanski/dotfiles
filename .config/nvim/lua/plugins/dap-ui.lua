local M = {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    keys = {
        { '<leader>xu', function() require('dapui').toggle('sidebar') end, desc = 'Toggle UI' },
        { '<leader>xes', function() require('dapui').float_element('scopes', {enter = true}) end, desc = 'Show scopes' },
        { '<leader>xew', function() require('dapui').float_element('watches', {enter = true}) end, desc = 'Show watches' },
        { '<leader>xeb', function() require('dapui').float_element('breakpoints', {enter = true}) end, desc = 'Show breakpoints' },
        { '<leader>xet', function() require('dapui').float_element('stacks', {enter = true}) end, desc = 'Show stacks' },
    },
}

M.config = function()
    require('dapui').setup {
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
end

return M
