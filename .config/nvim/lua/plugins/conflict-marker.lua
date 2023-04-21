local M = {
    'rhysd/conflict-marker.vim',
    event = 'VeryLazy',
    keys = {
        -- Cycle through conflict hunks
        { '<A-D>', ':ConflictMarkerNextHunk<cr>', desc = 'Next conflict hunk', mode = {'n', 'v'}},
        { '<A-U>', ':ConflictMarkerPrevHunk<cr>', desc = 'Previous conflict hunk', mode = {'n', 'v'} },
        -- Resolve conflicts
        { '<leader>rt', ':ConflictMarkerThemselves<cr>', desc = 'Theirs' },
        { '<leader>ro', ':ConflictMarkerOurselves<cr>', desc = 'Ours' },
        { '<leader>rb', ':ConflictMarkerBoth<cr>', desc = 'Both' },
        { '<leader>rB', ':ConflictMarkerBoth!<cr>', desc = 'Both, reversed' },
        { '<leader>rn', ':ConflictMarkerNone<cr>', desc = 'None' },
    },
}

M.config = function()
    vim.g.conflict_marker_enable_highlight = 0
    vim.g.conflict_marker_enable_mappings = 0
end

return M
