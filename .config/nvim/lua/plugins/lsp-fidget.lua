local M = {
    -- Display the LSP indexing progress in the lower right corner
    'j-hui/fidget.nvim',
    config = function()
        require('fidget').setup({
            text = {
                spinner = 'dots'
            }
        })
    end,
}

return M
