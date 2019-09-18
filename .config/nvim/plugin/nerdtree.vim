" === Bindings === "

"   Ctrl+n    - toogle sidebar
"   <leader>n - show current file in sidebar
map <C-n> :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>


" === Settings === "

" auto delete the buffer of a deleted file
let NERDTreeAutoDeleteBuffer = 1
" close nerdtree when opening a file
let NERDTreeQuitOnOpen = 1
" hide all the useless stuff above the tree
let NERDTreeMinimalUI = 1

let g:NERDTreeWinSize=40
let NERDTreeShowLineNumbers=1


" === Misc === "

" close vim when only nerdtree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
