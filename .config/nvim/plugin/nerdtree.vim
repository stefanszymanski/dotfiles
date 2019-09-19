" === Bindings === "

"   Ctrl+n    - toggle sidebar
"   <leader>n - toggle sidebar, show current file
map <silent><leader>n :call <SID>toggle()<CR>
map <silent><leader>N :call <SID>find()<CR>


" === Settings === "

" auto delete the buffer of a deleted file
let NERDTreeAutoDeleteBuffer = 1
" close nerdtree when opening a file
let NERDTreeQuitOnOpen = 1
" hide all the useless stuff above the tree
let NERDTreeMinimalUI = 1

let g:NERDTreeWinSize=55
let NERDTreeShowLineNumbers=1


" === Functions === "

" Toogle nerdtree, show current file inside cwd
function! s:find()
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        :NERDTreeClose
    else
        let l:fileStr = expand('%:p')
        :NERDTreeCWD
        exe ":NERDTreeFind " . fileStr
    endif
endfun

" Toggle nerdtree, load cwd
function! s:toggle()
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        :NERDTreeClose
    else
        :NERDTreeCWD
    endif
endfun


" === Hooks === "

" close vim when only nerdtree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
