local M = {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
}

M.config = function()
    -- vim.opt.list = true
    require('ibl').setup()
end

return M
