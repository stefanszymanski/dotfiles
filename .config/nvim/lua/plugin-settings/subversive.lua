local M = {}

M.config = function()
    local whichkey = require('which-key')

    vim.g.subversivePreserveCursorPosition = 1
    vim.g.subversivePromptWithCurrent = 1

    local opts = {silent = true, noremap = false}
    vim.api.nvim_set_keymap('n', 'R', '<Plug>(SubversiveSubstituteToEndOfLine)', opts)

    whichkey.register({
        name =                                          'replace',
        r = {'<Plug>(SubversiveSubstitute)',                 'replace {motion} in buffer'},
        m = {'<plug>(SubversiveSubstituteRange)',            'replace {motion} in {motion}'},
        w = {'<plug>(SubversiveSubstituteWordRange)',        'replace {motion} in {motion} and confirm'},
        M = {'<plug>(SubversiveSubstituteRangeConfirm)',     'replace word in {motion}'},
        W = {'<plug>(SubversiveSubstituteWordRangeConfirm)', 'replace word in {motion} and confirm'},
    }, {prefix = 'r'})

    whichkey.register({
        name = 'replace',
        m = {'<plug>(SubversiveSubstituteRange)',            'replace {motion} in {motion}'},
        M = {'<plug>(SubversiveSubstituteRangeConfirm)',     'replace word in {motion}'},
    }, {prefix = 'r', mode = 'x'})
end

return M
