local M = {
    'mfussenegger/nvim-dap',
    cmd = { 'BreakpointToggle', 'Debug', 'DapREPL' },
    keys = {
        { '<leader>xq', function() require('dap').close() end, desc = 'Close' },
        { '<leader>xc', function() require('dap').continue() end, desc = 'Continue' },
        { '<leader>xh', function() require('dap').run_to_cursor() end, desc = 'Continue to cursor' },
        { '<leader>xp', function() require('dap').pause() end, desc = 'Pause' },
        { '<leader>xb', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
        { '<leader>xC', function() require('dap').clear_breakpoint() end, desc = 'Clear breakpoints' },
        { '<leader>xr', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Clear breakpoints' },
        { '<leader>xr', function() require('dap').repl.toggle() end, desc = 'Clear breakpoints' },
        { '<leader>xsv', function() require('dap').step_over() end, desc = 'Step over' },
        { '<leader>xsi', function() require('dap').step_in() end, desc = 'Step in' },
        { '<leader>xso', function() require('dap').step_out() end, desc = 'Step out' },
    },
    dependencies = {
        'jbyuki/one-small-step-for-vimkind',
        'theHamsta/nvim-dap-virtual-text',
        'Pocco81/DAPInstall.nvim',
        {
            'nvim-telescope/telescope-dap.nvim',
            dependencies = {
                'mfussenegger/nvim-dap',
                'nvim-telescope/telescope.nvim',
            },
            keys = {
                { '<leader>xx', '<cmd>Telescope dap configurations<CR>', desc = 'Select configuration' },
                { '<leader>xl', '<cmd>Telescope dap list_breakpoints<CR>', desc = 'List breakpoints' },
                { '<leader>xf', '<cmd>Telescope dap frames<CR>', desc = 'List frames' },
            },
            config = function()
                require('telescope').load_extension('dap')
            end
        },
    },
}

M.config = function()
    local dap = require('dap')

    -- PHP
    dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { '/home/stefan/.local/share/nvim/dapinstall/php/vscode-php-debug/out/phpDebug.js' }
    }
    dap.configurations.php74fpm = {
        {
            type = 'php',
            request = 'launch',
            name = 'PHP 7.4 FPM',
            port = 9000
        }
    }
    dap.configurations.php = {
        {
            type = 'php',
            request = 'launch',
            name = 'PHP',
            port = 9003
        }
    }

    -- GDScript
    dap.adapters.godot = {
        type = "server",
        host = '127.0.0.1',
        port = 6006,
    }
    dap.configurations.gdscript = {
        {
            type = "godot",
            request = "launch",
            name = "Launch scene",
            project = "${workspaceFolder}",
            launch_scene = true,
        }
    }
end

return M
