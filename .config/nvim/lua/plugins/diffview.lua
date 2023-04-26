local M = {
    -- Diff view
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
        { '<leader>gS', '<cmd>DiffviewOpen<CR>', desc = 'Status' },
        { '<leader>gh', '<cmd>DiffviewFileHistory<CR>', desc = 'Document history' },
    },
}

M.config = function()
    require('diffview').setup()
end

return M
