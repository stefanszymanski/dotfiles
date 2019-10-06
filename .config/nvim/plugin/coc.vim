" === Gneral behaviour === "

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" === Bindings === "

" Diagnostics
"   <leader>ldp  - previous error or warning
"   <leader>ldn  - next error or warning
"   <leader>lda  - list all diagnostics
"   <leader>ldo  - show outline
"   <leader>lds  - search symbol in workspace 
"   <leader>ldr  - resume latest coc list
nnoremap <silent> <leader>ldp <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>ldp <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>ldn <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>lda :<C-u>CocList diagnostics<CR>
nnoremap <silent> <leader>ldo :<C-u>CocList -A outline<CR>
nnoremap <silent> <leader>lds :<C-u>CocList -I -A symbols<CR>
nnoremap <silent> <leader>ldr  :<C-u>CocListResume<CR>

" Completion
"   <ctrl+space> - show completion candidates
" When completions are shown
"   <return>     - accept selected completion
"   <tab>        - select next completion
"   <shift-tab>  - select previous completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<C-g>u<CR>'
inoremap <silent><expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ <SID>check_back_space() ? '<TAB>' :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<C-h>'

" Bindings for the symbol under the cursor
"   <leader>lc   - list references
"   <leader>lj   - jump to definition
"   <leader>li   - list implementations
"   <leader>lr   - rename
"   <leader>lt   - type definition
"   <leader>ld   - show documentation
"   <leader>gw   - grep
"   <leader>gb   - grep in current buffer 
"   <leader>Gw   - grep, interactive
"   <leader>Gb   - grep in current buffer, interactive 
nnoremap <silent> <leader>lc <Plug>(coc-references)
nnoremap <silent> <leader>lj <Plug>(coc-definition)
nnoremap <silent> <leader>li <Plug>(coc-implementation)
nnoremap <silent> <leader>lr <Plug>(coc-rename)
nnoremap <silent> <leader>lt <Plug>(coc-type-definition)
nnoremap <silent> <leader>ll :call <SID>show_documentation()<CR>
nnoremap <silent> <Leader>gw :exe 'CocList -A --normal --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <space>gb :exe 'CocList -A --normal --input='.expand('<cword>').' words'<CR>
nnoremap <silent> <Leader>Gw :exe 'CocList -I -A --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <space>Gb  :exe 'CocList -I -A --input='.expand('<cword>').' words'<CR>

" Formatting
xnoremap <silent> <leader>lf <Plug>(coc-format-selected)
nnoremap <silent> <leader>lf <Plug>(coc-format-selected)

" Refactoring
"   <leader>rf   - Open refactoring view
nnoremap <silent> <leader>rf <Plug>(coc-refactor)


" === Commands === "

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction


" === Helper functions === "

" Helper function for completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Helper function for displaying documentation
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

