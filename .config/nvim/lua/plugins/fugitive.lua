local M = {
    -- Vim commands for git
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
        { '<leader>gA', ':Git add %<cr>', desc = 'Stage document' },
        { '<leader>gr', ':Git reset HEAD %<cr>', desc = 'Reset document' },
        { '<leader>gR', ':Git reset HEAD .<cr>', desc = 'Reset all' },
        { '<leader>gf', ':Git fetch --all<cr>', desc = 'Fetch' },
        { '<leader>gC', ':Git commit<cr>', desc = 'Commit' },
        { '<leader>gp', ':Git pull<cr>', desc = 'Pull' },
        { '<leader>gP', ':Git push<cr>', desc = 'Push' },
    },
}

return M
