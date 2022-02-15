local M = {}

M.config = function()
    local dap = require('dap')
    local whichkey = require('which-key')

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

    whichkey.register({
        d = {
            name = 'Debug',
            s = {
                name = 'Step',
                v = {dap.step_over, 'Step over'},
                i = {dap.step_in,   'Step in'},
                o = {dap.step_out,  'Step out'},
            },
            x = {':Telescope dap configurations<cr>',                                       'Select configuration'},
            X = {dap.close,                                                                 'Close'},
            c = {dap.continue,                                                              'Continue'},
            h = {dap.run_to_cursor,                                                         'Continue to cursor'},
            p = {dap.pause,                                                                 'Pause'},
            b = {dap.toggle_breakpoint,                                                     'Toggle breakpoint'},
            B = {function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, 'Set conditional breakpoint'},
            l = {':Telescope dap list_breakpoints<cr>',                                     'List breakpoints'},
            C = {dap.clear_breakpoints,                                                     'Clear breakpoints'},
            r = {dap.repl.toggle,                                                           'Toggle REPL'},
            f = {':Telescope dap frames<cr>',                                               'List frames'},
        }
    }, {prefix = '<leader>'})
end

return M
