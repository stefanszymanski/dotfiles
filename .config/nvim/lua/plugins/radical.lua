local M = {
    -- Number conversion
    'glts/vim-radical',
    dependencies = {
         'glts/vim-magnum',
         'tpope/vim-repeat',
    },
    keys = {
        { 'gA', desc = 'Show number conversions', mode = { 'n', 'v' } },
        { 'crb', desc = 'To binary' },
        { 'crd', desc = 'To decimal' },
        { 'cro', desc = 'To octal' },
        { 'crx', desc = 'To hexadecimal' },
    }
}

return M
