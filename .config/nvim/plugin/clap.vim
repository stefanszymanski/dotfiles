let g:clap_layout = {'relative': 'editor', 'width': '80%', 'height': '60%', 'row': '10%', 'col': '10%'}
let g:clap_open_action = {'ctrl-o': 'edit','ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit'}
let g:clap_insert_mode_only = v:true
let g:clap_search_box_border_style = 'nil'

" disable any blinking
let g:clap_provider_grep_blink = [0, 0]
let g:clap_provider_coc_blink = [0, 0]


" === Grep in selected directory === "
" Register provider grep_directory
" It displays two dialogs consecutively:
"   1. directory finder (fd --type d)
"   2. grep2 inside the selected directory

let s:grep_directory = {}

function! s:grep_directory.source() abort
    " search for directories only
    let g:clap.context.finder = 'fd --type d'
    return g:clap#provider#files#.source()
endfunction

function! s:grep_directory.sink(selected) abort
    " call grep2 with the selected directory
    let s:dir = a:selected[: stridx(a:selected, ':')]
    execute join(['Clap', 'grep2', s:dir])
endfunction

let g:clap_provider_grep_directory = s:grep_directory


" === Grep in NerdTree === "
" Bind \ in NerdTree to grep in the current directory

autocmd VimEnter * call NERDTreeAddKeyMap({
    \ 'key': '\',
    \ 'scope': 'Node',
    \ 'callback': 'NERDTreeGrepHandler',
    \ 'quickHelpText': 'grep in directory'
\ })

function! NERDTreeGrepHandler(dirnode) abort
    let s:dir = a:dirnode.path.getDir().str()
    execute join(['Clap', 'grep2', s:dir])
endfunction


" === Bindings === "

" search in buffer
nnoremap <silent> <leader>st  :<C-u>Clap tags<CR>
nnoremap <silent> <leader>sl  :<C-u>Clap blines<CR>

" search in project
nnoremap <silent> <leader>sf  :<C-u>Clap files<CR>
nnoremap <silent> <leader>sF  :<C-u>Clap files +no-cache<CR>
nnoremap <silent> <leader>sT  :<C-u>Clap proj_tags<CR>
nnoremap <silent> <leader>gf  :<C-u>Clap git_diff_files<CR>

" grep in project (cached and uncached)
nnoremap <silent> <leader>sg  :<C-u>Clap grep2<CR>
nnoremap <silent> <leader>sG  :<C-u>Clap grep<CR>
" grep in selected directory
nnoremap <silent> <leader>si  :<C-u>Clap grep_directory<CR>
" grep word under cursor
nnoremap <silent> <leader>sw  :<C-u>Clap grep2 ++query=<cword><CR>
nnoremap <silent> <leader>sW  :<C-u>Clap grep ++query=<cword><CR>
" grep visual selection
vnoremap <silent> <leader>sg  :<C-u>Clap grep2 ++query=@visual<CR>
vnoremap <silent> <leader>sG  :<C-u>Clap grep ++query=@visual<CR>

" other searches
nnoremap <silent> <leader>bb  :<C-u>Clap buffers<CR>
nnoremap <silent> <leader>ww  :<C-u>Clap windows<CR>

nnoremap <silent> <leader>ss  :<C-u>Clap search_history<CR>
nnoremap <silent> <leader>sc  :<C-u>Clap command_history<CR>
nnoremap <silent> <leader>sr  :<C-u>Clap history<CR>
nnoremap <silent> <leader>sy  :<C-u>Clap yanks<CR>
nnoremap <silent> <leader>sj  :<C-u>Clap jumps<CR>
nnoremap <silent> <leader>sm  :<C-u>Clap marks<CR>
nnoremap <silent> <leader>sq  :<C-u>Clap quickfix<CR>
