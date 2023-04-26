local M = {
    -- Vim commands for git
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
        { '<leader>gA', ':Git add %<CR>', desc = 'Stage document' },
        { '<leader>gr', ':Git reset HEAD %<CR>', desc = 'Reset document' },
        { '<leader>gR', ':Git reset HEAD .<CR>', desc = 'Reset all' },
        { '<leader>gf', ':Git fetch --all<CR>', desc = 'Fetch' },
        { '<leader>gC', ':Git commit<CR>', desc = 'Commit' },
        { '<leader>gp', ':Git pull<CR>', desc = 'Pull' },
        { '<leader>gP', ':Git push<CR>', desc = 'Push' },
    },
}

return M
