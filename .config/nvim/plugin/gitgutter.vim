let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

let g:gitgutter_max_signs=1000

nnoremap <silent> yoG :GitGutterLineHighlightsToggle<CR>

" remap bindings
nmap <leader>ghs <Plug>(GitGutterStageHunk)
xmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)
