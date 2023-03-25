local M = {}

M.config = function()
    local legendary = require('legendary')
    local whichkey = require('which-key')
    local opts = {silent = true, noremap = true}

    vim.g.conflict_marker_enable_highlight = 0
    vim.g.conflict_marker_enable_mappings = 0

    -- Cycle through conflict hunks
    legendary.keymaps {
        {'<A-D>', ':ConflictMarkerNextHunk<cr>', opts = opts, description = 'Next conflict hunk'},
        {'<A-U>', ':ConflictMarkerPrevHunk<cr>', opts = opts, description = 'Previous conflict hunk'},
        {'<A-D>', ':ConflictMarkerNextHunk<cr>', opts = opts, mode = 'v', description = 'Next conflict hunk'},
        {'<A-U>', ':ConflictMarkerPrevHunk<cr>', opts = opts, mode = 'v', description = 'Previous conflict hunk'},
    }

    -- Resolve conflicts
    whichkey.register({
        r = {
            name = 'resolve conflict',
            t = {':ConflictMarkerThemselves<cr>', 'Theirs'},
            o = {':ConflictMarkerOurselves<cr>', 'Ours'},
            b = {':ConflictMarkerBoth<cr>', 'Both'},
            B = {':ConflictMarkerBoth!<cr>', 'Both, reversed'},
            n = {':ConflictMarkerNone<cr>', 'None'},
        }
    }, {prefix = '<leader>'})

end

return M
