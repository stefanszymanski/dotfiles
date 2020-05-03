" === General settings === "

let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1


" === Mappings === "

" e.g. "2riw replaces `iw` with register 2
nmap r  <Plug>(SubversiveSubstitute)
nmap rr <Plug>(SubversiveSubstituteLine)
nmap R  <Plug>(SubversiveSubstituteToEndOfLine)

" Substitute result of a motion inside another motion
" e.g. <leader>riwip replaces all instances of `iw` inside `ip`
nmap <leader>rr  <Plug>(SubversiveSubstituteRange)
xmap <leader>rr  <Plug>(SubversiveSubstituteRange)
nmap <leader>rw <Plug>(SubversiveSubstituteWordRange)

" Same but asks for confirmation for each substitution
nmap <leader>rR  <Plug>(SubversiveSubstituteRangeConfirm)
xmap <leader>rR  <Plug>(SubversiveSubstituteRangeConfirm)
nmap <leader>rW <Plug>(SubversiveSubstituteWordRangeConfirm)

" TODO maybe add bindings for deletion and substitution without prompt
