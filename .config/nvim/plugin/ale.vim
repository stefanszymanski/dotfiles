scriptencoding utf-8

" Set characters and formats
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '➤'
let g:ale_sign_info = '🛈'
let g:ale_echo_msg_format = '%severity%: %linter%: %s'

" Lint when a file is opened
let g:ale_lint_on_enter = 1

" Fix and lint at save
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" Always lint on text changes
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 250

" Keep the sign gutter always open
let g:ale_sign_column_always = 1

" Display error information in the status bar
let g:airline#extensions#ale#enabled = 1


let g:ale_completion_enabled = 1


" Set fixers
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}


" Bindings
nmap <silent> <leader>ln <Plug>(ale_next_wrap)
nmap <silent> <leader>lp <Plug>(ale_previous_wrap)
