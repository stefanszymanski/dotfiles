let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'which_key']

" remap to same prefixes as unimpaired
nmap <silent><unique> yoI <Plug>IndentGuidesToggle
nmap <silent><unique> [oI <Plug>IndentGuidesDisable
nmap <silent><unique> ]oI <Plug>IndentGuidesEnable
