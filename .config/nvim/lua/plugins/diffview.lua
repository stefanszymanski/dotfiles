local M = {
    -- Diff view
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        { '<leader>gS', '<cmd>DiffviewOpen<cr>', desc = 'Status' },
        { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'Document history' },
    },
}

M.config = function()
    require('diffview').setup()
end

return M
