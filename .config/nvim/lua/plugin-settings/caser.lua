local M = {}

M.config = function()
    local whichkey = require('which-key')

    vim.g.caser_prefix = '<leader>c'

    whichkey.register({
        c = {
            name = 'Case manipulation',
            ['_'] = '[m] to snake_case',
            m = '[m] to UpperCamelCase',
            p = '[m] to UpperCamelCase',
            c = '[m] to lowerCamelCase',
            u = '[m] to UPPER_CASE',
            U = '[m] to UPPER_CASE',
            ['-'] = '[m] to kebap-case',
            k = '[m] to kebap-case',
            K = '[m] to Upper-Kebap-Case',
            ['.'] = '[m] to dot.case',
            ['<space>'] = '[m] to space case',
            t = '[m] to Title Case',
            s = '[m] to Sentence case',
        }
    }, {prefix = '<leader>'})

    whichkey.register({
        c = {
            name = 'Case manipulation',
            ['_'] = 'To snake_case',
            m = 'To UpperCamelCase',
            p = 'To UpperCamelCase',
            c = 'To lowerCamelCase',
            u = 'To UPPER_CASE',
            U = 'To UPPER_CASE',
            ['-'] = 'To kebap-case',
            k = 'To kebap-case',
            K = 'To Upper-Kebap-Case',
            ['.'] = 'To dot.case',
            ['<space>'] = 'To space case',
            t = 'To Title Case',
            s = 'To Sentence case',
        }
    }, {prefix = '<leader>', mode = 'v'})
end

return M
