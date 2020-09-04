" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" === Mappings === "

" Diagnostics
"   [d  - previous error or warning
"   ]d  - next error or warning
"   <leader>lD   - list all diagnostics
"   <leader>lo   - search outline
"   <leader>ls   - search symbol in workspace 
"   <leader>lC   - resume latest coc list
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> [D <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]D <Plug>(coc-diagnostic-next-error)
" the following mappings were replaced in plugin/clap.vim
" nnoremap <silent> <leader>ld :<C-u>CocList -A diagnostics<CR>
" nnoremap <silent> <leader>lo :<C-u>CocList -A outline<CR>
" nnoremap <silent> <leader>ls :<C-u>CocList -I -A symbols<CR>
nnoremap <silent> <leader>lC  :<C-u>CocListResume<CR>

" Completion
"   <ctrl><space>   - show completion candidates
" When completions are shown
"   <ctrl><return>  - accept selected completion
"   <tab>           - select next completion
"   <shift><tab>    - select previous completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<C-g>u<CR>'
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

" Bindings for the symbol under the cursor
"   <leader>lc   - list references
"   <leader>lj   - jump to definition
"   <leader>li   - list implementations
"   <leader>lr   - rename
"   <leader>lt   - jump to type definition
"   <leader>ld   - show documentation
"   <leader>ll   - show documentation
nmap <silent> <leader>lc <Plug>(coc-references)
nmap <silent> <leader>lj <Plug>(coc-definition)
nmap <silent> <leader>lD <Plug>(coc-declaration)
" nmap <silent> <leader>lC <Plug>(coc-codelens-action)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nnoremap <silent> <leader>ll :call <SID>show_documentation()<CR>

" Formatting
xmap <silent> <leader>lf <Plug>(coc-format-selected)
nmap <silent> <leader>lf <Plug>(coc-format-selected)
nmap <silent> <leader>lF <Plug>(coc-format)

" Refactoring
"   <leader>rf   - Open refactoring view
nmap <silent> <leader>lR <Plug>(coc-refactor)


" === Text objects === "

omap <silent> if <Plug>(coc-funcobj-i)
omap <silent> af <Plug>(coc-funcobj-a)
vmap <silent> if <Plug>(coc-funcobj-i)
vmap <silent> af <Plug>(coc-funcobj-a)


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

" Helper function for displaying documentation
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

