local M = {
    -- Swap list elements, e.g. arguments
    'mizlan/iswap.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },
    keys = {
        { 'gs', ':ISwapWith<CR>', desc = 'Swap this' },
        { 'gS', ':ISwap<CR>', desc = 'Swap' },
    },
}

M.config = function()
    require('iswap').setup {
        keys = 'asdfghjkl',
        autoswap = true,
    }
end

return M
