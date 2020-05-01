let g:clap_layout = {'relative': 'editor', 'width': '80%', 'height': '60%', 'row': '10%', 'col': '10%'}
let g:clap_open_action = {'ctrl-o': 'edit','ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit'}
let g:clap_insert_mode_only = v:true

let g:clap_provider_coc_blink = [0, 0]

" TODO Interactive by content pattern and path pattern
" TODO Continue latest search 


" search in buffer
nnoremap <silent> <leader>st  :<C-u>Clap tags<CR>
nnoremap <silent> <leader>sl  :<C-u>Clap blines<CR>

" search in project
nnoremap <silent> <leader>sf  :<C-u>Clap files<CR>
nnoremap <silent> <leader>sF  :<C-u>Clap files +no-cache<CR>
nnoremap <silent> <leader>sT  :<C-u>Clap proj_tags<CR>
nnoremap <silent> <leader>gg  :<C-u>Clap grep2<CR>
nnoremap <silent> <leader>gG  :<C-u>Clap grep<CR>
nnoremap <silent> <leader>gf  :<C-u>Clap git_diff_files<CR>

" coc lists
nnoremap <silent> <leader>ld  :<C-u>Clap coc_diagnostics<CR>
nnoremap <silent> <leader>lo  :<C-u>Clap coc_outline<CR>
nnoremap <silent> <leader>ls  :<C-u>Clap coc_symbols<CR>

" other searches
nnoremap <silent> <leader>ss  :<C-u>Clap search_history<CR>
nnoremap <silent> <leader>sc  :<C-u>Clap command_history<CR>
nnoremap <silent> <leader>sr  :<C-u>Clap history<CR>
nnoremap <silent> <leader>sy  :<C-u>Clap yanks<CR>
nnoremap <silent> <leader>sj  :<C-u>Clap jumps<CR>
nnoremap <silent> <leader>sm  :<C-u>Clap marks<CR>
nnoremap <silent> <leader>sq  :<C-u>Clap quickfix<CR>
nnoremap <silent> <leader>bb  :<C-u>Clap buffers<CR>
nnoremap <silent> <leader>ww  :<C-u>Clap windows<CR>
