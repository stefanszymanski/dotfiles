local M = {
    -- Move by two-character search pattern
    'ggandor/leap.nvim',
    dependencies = {
        'tpope/vim-repeat',
    },
    keys = {
        { 'gh', '<Plug>(leap-forward-x)', desc = 'Search forward', mode = {'n', 'v', 'o'}},
        { 'gH', '<Plug>(leap-backward-x)', desc = 'Search backward', mode = {'n', 'v', 'o'}},
    }
}

return M
