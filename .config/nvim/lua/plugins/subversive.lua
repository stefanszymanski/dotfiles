local M = {
    -- Replace from register
    'svermeulen/vim-subversive',
    keys = {
        { 'rr', '<Plug>(SubversiveSubstitute)', desc = 'replace {motion} in buffer' },
        { 'rm', '<plug>(SubversiveSubstituteRange)', desc = 'replace {motion} in {motion}' },
        { 'rw', '<plug>(SubversiveSubstituteWordRange)', desc = 'replace {motion} in {motion} and confirm' },
        { 'rM', '<plug>(SubversiveSubstituteRangeConfirm)', desc = 'replace word in {motion}' },
        { 'rW', '<plug>(SubversiveSubstituteWordRangeConfirm)', desc = 'replace word in {motion} and confirm' },
        { 'rm', '<plug>(SubversiveSubstituteRange)', desc = 'replace {motion} in {motion}', mode = 'x'},
        { 'rM', '<plug>(SubversiveSubstituteRangeConfirm)', desc = 'replace word in {motion}', mode = 'x' },
    },
}

M.config = function()
    vim.g.subversivePreserveCursorPosition = 1
    vim.g.subversivePromptWithCurrent = 1
end

return M
