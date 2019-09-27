" === Behaviour === "

let g:AutoPairsFlyMode = 0


" === Bindings === "

" Disable default bindings
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsMoveCharacter = ''

" Add custom bindings
"   yoP  - toggle the plugin
nnoremap <silent> yoP :call AutoPairsToggle()<CR>


" === Additional auto pairs === "

au FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'})
