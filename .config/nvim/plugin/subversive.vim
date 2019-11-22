let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1


" e.g. "2riw replaces `iw` with register 2
nmap r  <Plug>(SubversiveSubstitute)
nmap rr <Plug>(SubversiveSubstituteLine)
nmap R  <Plug>(SubversiveSubstituteToEndOfLine)

" Substitute result of a motion inside another motion
" e.g. <leader>riwip replaces all instances of `iw` inside `ip`
nmap <leader>r  <Plug>(SubversiveSubstituteRange)
xmap <leader>r  <Plug>(SubversiveSubstituteRange)
nmap <leader>rr <Plug>(SubversiveSubstituteWordRange)

" Same but asks for confirmation for each substitution
nmap <leader>cr  <Plug>(SubversiveSubstituteRangeConfirm)
xmap <leader>cr  <Plug>(SubversiveSubstituteRangeConfirm)
nmap <leader>crr <Plug>(SubversiveSubstituteWordRangeConfirm)

" TODO maybe add bindings for deletion and substitution without prompt
