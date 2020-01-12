let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

nnoremap <silent> yoG :GitGutterLineHighlightsToggle<CR>

" remap bindings
nmap <leader>gs <Plug>(GitGutterStageHunk)
xmap <leader>gs <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
