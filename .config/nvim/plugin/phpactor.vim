" === Configuration for plugin phpactor === "
"   Documentation: https://phpactor.github.io/phpactor/index.html
"   Github: https://github.com/phpactor/phpactor


" Use the development version of phpactor
let g:phpactorBranch = "develop"


" === Bindings === "

" Refactoring
"   <Leader>rmm   - Display context menu
"   <Leader>ree   - Extract expression (in normal and visual mode)
"   <Leader>rem   - Extract method (visual mode)
"   <Leader>rv    - Change visibility (cycles through them)
"   <Leader>rcc   - Complete constructor (create and assign properties)
"   <Leader>ric   - Implement constracts (creates methods for interfaces)
nmap <silent> <Leader>rmm :call phpactor#ContextMenu()<CR>
nmap <silent> <Leader>ree :call phpactor#ExtractExpression(v:false)<CR>
vmap <silent><Leader>ree :<C-U>call phpactor#ExtractExpression(v:true)<CR>
vmap <silent><Leader>rem :<C-U>call phpactor#ExtractMethod()<CR>
nmap <silent> <Leader>rv :call phpactor#ChangeVisibility()<CR>
nmap <silent> <Leader>rcc :call phpactor#Transform('complete_constructor')<CR>
nmap <silent> <Leader>ric :call phpactor#Transform('implement_contracts')<CR>
