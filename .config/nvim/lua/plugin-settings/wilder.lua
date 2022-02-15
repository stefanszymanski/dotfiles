local M = {}

M.config = function()
    vim.cmd [[
        call wilder#setup({'modes': [':']})
        call wilder#set_option('pipeline', [
          \   wilder#branch(
          \     wilder#cmdline_pipeline({
          \       'fuzzy': 1,
          \       'fuzzy_filter': wilder#lua_fzy_filter(),
          \     }),
          \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern(),
          \       'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \     }),
          \   ),
          \ ])
        call wilder#set_option('renderer', wilder#popupmenu_renderer({
          \ 'highlighter': [
          \   wilder#lua_fzy_highlighter(),
          \ ],
          \ 'highlights': {
          \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#d2c934'}]),
          \ },
          \ 'left': [
          \   ' ', wilder#popupmenu_devicons(),
          \ ],
          \ 'right': [
          \   ' ', wilder#popupmenu_scrollbar(),
          \ ],
          \ }))
    ]]

end

return M
