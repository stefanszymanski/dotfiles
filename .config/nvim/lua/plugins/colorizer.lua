local M = {
    -- Highlight color strings with their color
    'norcalli/nvim-colorizer.lua',
    ft = {'css', 'less', 'scss', 'javascript'},
    keys = {
        { 'yoC', '<cmd>ColorizerToggle<CR>', desc = 'Colorizer' },
        { '[oC', '<cmd>ColorizerAttachToBuffer<CR>', desc = 'Colorizer' },
        { ']oC', '<cmd>ColorizerDetachFromBuffer<CR>', desc = 'Colorizer' },
    },
}

M.config = function()
    require('colorizer').setup({
        'css',
        'less',
        'scss',
        'javascript',
        'html',
    }, {
        css = true
    })
end

return M
