local M = {
    'gelguy/wilder.nvim',
    event = 'CmdlineEnter',
    dependencies = { 'romgrk/fzy-lua-native' },
}

M.config = function()
    local wilder = require('wilder')
    wilder.setup({ modes = { ':', '/', '?' } })
    wilder.set_option('use_python_remote_plugin', 0)
    wilder.set_option('pipeline', {
        wilder.branch(wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
        }), wilder.vim_search_pipeline())
    })
    wilder.set_option('renderer', wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = 'rounded',
        highlighter = wilder.lua_fzy_highlighter(),
        highlights = {
            default = 'Normal',
            accent = wilder.make_hl('WilderAccent', { { a = 1 }, { a = 1 }, { foreground = '#d79921' } }),
        },
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
    })))
end

return M
