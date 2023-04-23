local M = {
    -- Highlighting and easier repitition of f/F/t/T searches
    'ggandor/flit.nvim',
    dependencies = {
        'ggandor/leap.nvim',
    },
    keys = { 'f', 'F', 't', 'T' },
}

M.config = function()
    require('flit').setup()
end

return M
