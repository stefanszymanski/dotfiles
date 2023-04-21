local M = {
    -- Swap list elements, e.g. arguments
    'mizlan/iswap.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },
    keys = {
        { 'gs', ':ISwapWith<cr>', desc = 'Swap this' },
        { 'gS', ':ISwap<cr>', desc = 'Swap' },
    },
}

M.config = function()
    require('iswap').setup {
        keys = 'asdfghjkl',
        autoswap = true,
    }
end

return M
