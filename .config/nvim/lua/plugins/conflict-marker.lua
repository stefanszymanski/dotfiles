local M = {
    'rhysd/conflict-marker.vim',
    event = 'VeryLazy',
    keys = {
        -- Cycle through conflict hunks
        { '<M-D>', ':ConflictMarkerNextHunk<CR>', desc = 'Next conflict hunk', mode = {'n', 'v'}},
        { '<M-U>', ':ConflictMarkerPrevHunk<CR>', desc = 'Previous conflict hunk', mode = {'n', 'v'} },
        -- Resolve conflicts
        { '<leader>rt', ':ConflictMarkerThemselves<CR>', desc = 'Theirs' },
        { '<leader>ro', ':ConflictMarkerOurselves<CR>', desc = 'Ours' },
        { '<leader>rb', ':ConflictMarkerBoth<CR>', desc = 'Both' },
        { '<leader>rB', ':ConflictMarkerBoth!<CR>', desc = 'Both, reversed' },
        { '<leader>rn', ':ConflictMarkerNone<CR>', desc = 'None' },
    },
}

M.config = function()
    vim.g.conflict_marker_enable_highlight = 0
    vim.g.conflict_marker_enable_mappings = 0
end

return M
