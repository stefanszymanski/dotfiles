" This plugin allows to define a snippet per projection that get expanded when
" a new file is created.
" 
" Copied from https://noahfrederick.com/log/vim-templates-with-ultisnips-and-projectionist
" and slightly modified.

function! s:try_insert(snip)
  execute "normal! i" . a:snip . "\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
  if g:ulti_expand_res == 0
    silent! undo
  endif
  return g:ulti_expand_res
endfunction

function! s:insertSnippet() abort
  let filename = expand('%')
  " Abort on non-empty buffer or extant file
  if !(line('$') == 1 && getline('$') == '') || filereadable(filename)
    return
  endif
  if !empty('b:projectionist')
    " Loop through projections with 'snippet' key and try each one until the
    " snippet expands
    for [root, value] in projectionist#query('snippet')
      if s:try_insert(value)
        return
      endif
    endfor
  endif
endfunction

augroup ultisnips_custom
  autocmd!
  autocmd User ProjectionistActivate silent! call s:insertSnippet()
  autocmd BufNewFile * silent! call s:insertSnippet()
augroup END
