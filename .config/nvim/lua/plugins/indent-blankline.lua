local M = {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
}

M.config = function()
    -- vim.opt.list = true
    require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = false,
    }
end

return M
