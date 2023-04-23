local M = {
    -- Change word casing
    'arthurxavierx/vim-caser',
    keys = {
        { '<leader>c_', desc = '[m] to snake_case' },
        { '<leader>cm', desc = '[m] to UpperCamelCase' },
        { '<leader>cp', desc = '[m] to UpperCamelCase' },
        { '<leader>cc', desc = '[m] to lowerCamelCase' },
        { '<leader>cu', desc = '[m] to UPPER_CASE' },
        { '<leader>cU', desc = '[m] to UPPER_CASE' },
        { '<leader>c-', desc = '[m] to kebap-case' },
        { '<leader>ck', desc = '[m] to kebap-case' },
        { '<leader>cK', desc = '[m] to Upper-Kebap-Case' },
        { '<leader>c.', desc = '[m] to dot.case' },
        { '<leader>c<space>', desc = '[m] to space case' },
        { '<leader>ct', desc = '[m] to Title Case' },
        { '<leader>cs', desc = '[m] to Sentence case' },
        { '<leader>c_', desc = 'To snake_case', mode = 'v' },
        { '<leader>cm', desc = 'To UpperCamelCase', mode = 'v' },
        { '<leader>cp', desc = 'To UpperCamelCase', mode = 'v' },
        { '<leader>cc', desc = 'To lowerCamelCase', mode = 'v' },
        { '<leader>cu', desc = 'To UPPER_CASE', mode = 'v' },
        { '<leader>cU', desc = 'To UPPER_CASE', mode = 'v' },
        { '<leader>c-', desc = 'To kebap-case', mode = 'v' },
        { '<leader>ck', desc = 'To kebap-case', mode = 'v' },
        { '<leader>cK', desc = 'To Upper-Kebap-Case', mode = 'v' },
        { '<leader>c.', desc = 'To dot.case', mode = 'v' },
        { '<leader>c<space>', desc = 'To space case', mode = 'v' },
        { '<leader>ct', desc = 'To Title Case', mode = 'v' },
        { '<leader>cs', desc = 'To Sentence case', mode = 'v' },
    },
}

M.init = function()
    vim.g.caser_prefix = '<leader>c'
end

return M
