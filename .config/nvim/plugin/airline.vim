" theme
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
let g:airline_solarized_bg='dark'

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_close_button = 0

" coc
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = 'E:'
let g:airline#extensions#coc#warning_symbol = 'W:'
let g:airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
