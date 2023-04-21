local M = {
    -- Highlight color strings with their color
    'norcalli/nvim-colorizer.lua',
    ft = {'css', 'less', 'scss', 'javascript'},
    keys = {
        { 'yoC', '<cmd>ColorizerToggle<cr>', desc = 'Colorizer' },
        { '[oC', '<cmd>ColorizerAttachToBuffer<cr>', desc = 'Colorizer' },
        { ']oC', '<cmd>ColorizerDetachFromBuffer<cr>', desc = 'Colorizer' },
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
