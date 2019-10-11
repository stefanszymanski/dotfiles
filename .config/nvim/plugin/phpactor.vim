" === Configuration for plugin phpactor === "
"   Documentation: https://phpactor.github.io/phpactor/index.html
"   Github: https://github.com/phpactor/phpactor


" Use the development version of phpactor
let g:phpactorBranch = "develop"


" === Bindings === "

" Refactoring
"   <Leader>lp    - Display context menu
"   <Leader>ln    - Display navigation menu
"   <Leader>ree   - Extract expression (in normal and visual mode)
"   <Leader>rem   - Extract method (visual mode)
"   <Leader>rau   - Add missing use statement for class under cursor
"   <Leader>rt    - Display transform menu
nmap <silent> <Leader>lp :call phpactor#ContextMenu()<CR>
nmap <silent> <Leader>ln :call phpactor#Navigate()<CR>
nmap <silent> <Leader>ree :call phpactor#ExtractExpression(v:false)<CR>
vmap <silent> <Leader>ree :<C-U>call phpactor#ExtractExpression(v:true)<CR>
vmap <silent> <Leader>rem :<C-U>call phpactor#ExtractMethod()<CR>
nmap <silent> <Leader>rau :call phpactor#UseAdd()<CR>
nmap <silent> <Leader>rt :call phpactor#Transform()<CR>

