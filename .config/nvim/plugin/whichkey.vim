" === Custom modifications === "
" Because WhichKey doesn't distinguish between bindings for normal and visual
" mode, I wrapped it and extended the configuration format.
" Instead of 
"   `key: value` 
" it's possible to write 
"   `key: {'n': normal_value, 'v': visual_value}`
" Only 'n' or 'v' must be present. If none of them is configured, the key is
" ignored.

" register replacements for the original commands
command! -bang -nargs=1 WhichKey2 call s:whichkey(0, <args>)
command! -bang -nargs=1 -range WhichKeyVisual2 call s:whichkey(1, <args>)

function! s:whichkey(visual, key)
    call s:create_map(a:visual, a:key)
    call which_key#start(a:visual, 0, a:key)
endfunction

function! s:create_map(visual, key)
    if has_key(g:which_key_maps, a:key)
        let s:local_map_name = g:which_key_maps[a:key]
        let s:real_map_name = s:get_real_map_name(s:local_map_name)
        let s:origin = {'s:' . s:local_map_name}
        let s:target = {s:real_map_name}
        call s:create_map_level(a:visual, s:origin, s:target)
    endif
    " echo s:target
    return s:target
endfunction

function! s:create_map_level(visual, origin, target)
    let s:TYPE = g:which_key#util#TYPE
    for [key, value] in items(a:origin)
        if type(value) == s:TYPE.dict
            if has_key(value, 'name')
                " recursivly create a submap
                if (!has_key(a:target, key))
                    let a:target[key] = {}
                endif
                call s:create_map_level(a:visual, value, a:target[key])
            else
                if a:visual && has_key(value, 'v')
                    " take the visual mode value
                    let a:target[key] = value.v
                elseif !a:visual && has_key(value, 'n')
                    " take the normal mode value
                    let a:target[key] = value.n
                elseif has_key(a:target, key)
                    " unset the value
                    unlet a:target[key]
                endif
            endif
        " elseif type(value) == s:TYPE.list
        "     if a:visual && has_key(value[1], 'v')
        "         " take the visual mode value
        "         let a:target[key] = [value[0], value[1].v]
        "     elseif !a:visual && has_key(value[1], 'n')
        "         " take the normal mode value
        "         let a:target[key] = [value[0], value[1].n]
        "     elseif has_key(a:target, key)
        "         " unset the value
        "         unlet a:target[key]
        "     endif
        else
            " take the original value
            let a:target[key] = value
        endif
    endfor
endfunction

function! s:get_real_map_name(local_name)
    return 'g:which_key_' . a:local_name
endfunction

function! s:register_map(key, local_name)
    if !exists('g:which_key_maps')
        let g:which_key_maps = {}
    endif
    let s:real_name = s:get_real_map_name(a:local_name)
    call which_key#register(a:key, s:real_name)
    exec 'let ' . s:real_name . '= {}'
    let g:which_key_maps[a:key] = a:local_name
endfunction


" === General behaviour === "

let g:which_key_flatten = 1
let g:which_key_fallback_to_native_key = 1
let g:which_key_use_floating_win = 1
let g:which_key_run_map_on_popup = 1
" let g:which_key_timeout = 500
" let g:which_key_ignore_invalid_key = 1

" hide statusline
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" === Bindings === "

call s:register_map(' ', 'map_leader')
call s:register_map('y', 'map_y')
call s:register_map('[', 'map_sqo')
call s:register_map(']', 'map_sqc')
call s:register_map('g', 'map_g')
call s:register_map('y', 'map_y')

nnoremap <silent> <leader> :<c-u>WhichKey2 '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual2 '<Space>'<CR>
nnoremap <silent> y :<c-u>WhichKey2 'y'<CR>
nnoremap <silent> [ :<c-u>WhichKey2 '['<CR>
vnoremap <silent> [ :<c-u>WhichKeyVisual2 '['<CR>
nnoremap <silent> ] :<c-u>WhichKey2 ']'<CR>
vnoremap <silent> ] :<c-u>WhichKeyVisual2 ']'<CR>
nnoremap <silent> g :<c-u>WhichKey2 'g'<CR>
vnoremap <silent> g :<c-u>WhichKeyVisual2 'g'<CR>
nnoremap <silent> y :<c-u>WhichKey2 'y'<CR>


" === Maps === "

let s:map_leader =  {
    \ '/': 'search in project',
    \ 'u': {'n': 'toggle Mundo buffer'},
    \ 'n': {'n': 'toggle Nerdtree'},
    \ 'N': {'n': 'open Nerdtree on current file'},
    \ 'y': 'yield to system clipboard',
    \ 'p': 'paste from system clipboard',
\ }
let s:map_leader.b = {
    \ 'name': '+blackhole-actions',
    \ 'c': 'c',
    \ 'C': 'C',
    \ 'cc': 'cc',
    \ 'd': 'd',
    \ 'D': 'D',
    \ 'dd': 'dd',
\ }
let s:map_leader.c = {
    \ 'name': '+camel-case-sensitive-motions',
    \ 'b': 'b',
    \ 'e': 'e',
    \ 'w': 'w',
\ }
let s:map_leader.r = {
    \ 'name': '+replace',
    \ 'r': {'n': 'replace [m] in [m]', 'v': 'replace selection in [m]'},
    \ 'R': {'n': 'replace [m] in [m] and confirm', 'v': 'replace selection in [m] and confirm'},
    \ 'w': {'n': 'replace word in [m]'},
    \ 'W': {'n': 'replace word in [m] and confirm'},
\ }
let s:map_leader.l = {
    \ 'name': '+language',
    \ 'c': {'n': 'list references'},
    \ 'j': {'n': 'jump to definition'},
    \ 'i': {'n': 'list implementations'},
    \ 'r': {'n': 'rename'},
    \ 't': {'n': 'show type definition'},
    \ 'l': {'n': 'show documentation'},
    \ 'D': {'n': 'jump to declaration'},
    \ 'R': {'n': 'open refactoring buffer'},
    \ 'f': {'n': 'format [m]', 'v': 'format selection'},
\ }
let s:map_leader.l.d = {'n': {
    \ 'name': '+diagnostics',
    \ 'p': 'previous error or warning',
    \ 'n': 'next error or warning',
    \ 'a': 'list all diagnostics',
    \ 'o': 'display outline',
    \ 's': 'search symbols',
    \ 'r': 'resume latest search',
\}}
let s:map_leader.f = {'n': {
    \ 'name': '+find',
    \ 'b': 'list buffers',
    \ 'c': 'continue latest search',
    \ 'f': 'list files in workspace',
    \ 'r': 'list mru files'
\}}
let s:map_leader.g = {
    \ 'name': '+git',
    \ 'b': {'n': 'blame'},
    \ 's': 'stage hunk',
    \ 'u': {'n': 'undo hunk'},
    \ 'p': {'n': 'preview hunk'},
\ }
let s:map_leader.C = {
    \ 'name': '+case-manipulation',
    \ '_': {'n': '[m] to snake_case', 'v': 'selection to snake_case'},
    \ 'm': {'n': '[m] to UpperCamelCase', 'v': 'selection to UpperCamelCase'},
    \ 'p': {'n': '[m] to UpperCamelCase', 'v': 'selection to UpperCamelCase'},
    \ 'c': {'n': '[m] to lowerCamelCase', 'v': 'selection to lowerCamelCase'},
    \ 'u': {'n': '[m] to UPPER_CASE', 'v': 'selection to UPPER_CASE'},
    \ 'U': {'n': '[m] to UPPER_CASE', 'v': 'selection to UPPER_CASE'},
    \ '-': {'n': '[m] to kebap-case', 'v': 'selection to kebap-case'},
    \ 'k': {'n': '[m] to kebap-case', 'v': 'selection to kebap-case'},
    \ 'K': {'n': '[m] to Upper-Kebap-Case', 'v': 'selection to Upper-Kebap-Case'},
    \ '.': {'n': '[m] to dot.case', 'v': 'selection to dot.case'},
    \ ' ': {'n': '[m] to space case', 'v': 'selection to space case'},
    \ 't': {'n': '[m] to Title Case', 'v': 'selection to Title Case'},
    \ 's': {'n': '[m] to Sentence case', 'v': 'selection to Sentence case'}
\}

let s:unimpaired_bindings = {'n': {
    \ 's': 'spell',
    \ 'b': 'background',
    \ 'c': 'cursorline',
    \ '-': 'cursorline',
    \ '_': 'cursorline',
    \ 'x': 'cursorline cursorcolumn',
    \ '+': 'cursorline cursorcolumn',
    \ 'u': 'cursorcolumn',
    \ '|': 'cursorcolumn',
    \ 'n': 'number',
    \ 'd': 'diffthis/diffoff',
    \ 'G': 'gitgutter line highlighting',
    \ 'h': 'hlsearch',
    \ 'I': 'indent guides',
    \ 'i': 'ignorecase',
    \ 'l': 'list',
    \ 'r': 'relativenumber',
    \ 'p': 'paste',
    \ 'v': 'virtualedit',
    \ 'w': 'wrap'
\}}

let s:map_y = {
    \ 's': 'surround [m] with [...]',
    \ 'S': 'surround [m] and wrap with [...]',
    \ 'Ss': 'surround line with [...] and wrap',
    \ 'ss': 'surround line with [...]',
\}
let s:map_y.o = copy(s:unimpaired_bindings)
let s:map_y.o.n.name = '+toggle'

let s:map_sqo = {
    \ 'a': {'n': ':previous'},
    \ 'A': {'n': ':first'},
    \ 'b': {'n': ':bprevious'},
    \ 'B': {'n': ':bfirst'},
    \ 'l': {'n': ':lprevious'},
    \ 'L': {'n': ':lfirst'},
    \ '<C-L>': {'n': ':lpfile'},
    \ 'q': {'n': ':cprevious'},
    \ 'Q': {'n': ':cfirst'},
    \ '<C-Q>': {'n': ':cpfile'},
    \ 't': {'n': ':tprevious'},
    \ 'T': {'n': ':tfirst'},
    \ '<C-T>': {'n': ':ptprevious'},
    \ 'u': {'n': 'url encode [m]', 'v': 'url encode selection'},
    \ 'uu': {'n': 'url encode line'},
    \ 'x': {'n': 'xml encode [m]', 'v': 'xml encode selection'},
    \ 'xx': {'n': 'xml encode line'},
    \ 'y': {'n': 'c string encode [m]', 'v': 'c string encode selection'},
    \ 'yy': {'n': 'c string encode line'},
    \ 'p': {'n': 'paste above'},
    \ 'P': {'n': 'paste above'},
    \ 'e': {'n': 'move line up', 'v': 'move selected lines up'},
    \ ' ': {'n': 'add blank line above'},
    \ 'f': {'n': 'previous file in directory'},
    \ 'n': 'previous SCM conflict',
    \ '[': {'n': 'previous function or class'},
    \ 'c': {'n': 'previous git hunk'},
    \ '%': 'which_key_ignore',
\}
let s:map_sqo.o = copy(s:unimpaired_bindings)
let s:map_sqo.o.n.name = '+enable'

let s:map_sqc = {
    \ 'a': {'n': ':next'},
    \ 'A': {'n': ':last'},
    \ 'b': {'n': ':bnext'},
    \ 'B': {'n': ':blast'},
    \ 'l': {'n': ':lnext'},
    \ 'L': {'n': ':llast'},
    \ '<C-L>': {'n': ':lnfile'},
    \ 'q': {'n': ':cnext'},
    \ 'Q': {'n': ':clast'},
    \ '<C-Q>': {'n': ':cnfile'},
    \ 't': {'n': ':tnext'},
    \ 'T': {'n': ':tlast'},
    \ '<C-T>': {'n': ':ptnext'},
    \ 'u': {'n': 'url decode [m]', 'v': 'url decode selection'},
    \ 'uu': {'n': 'url decode line'},
    \ 'x': {'n': 'xml decode [m]', 'v': 'xml decode selection'},
    \ 'xx': {'n': 'xml decode line'},
    \ 'y': {'n': 'c string decode [m]', 'v': 'c string decode selection'},
    \ 'yy': {'n': 'c string decode line'},
    \ 'p': {'n': 'paste below'},
    \ 'P': {'n': 'paste below'},
    \ 'e': {'n': 'move line down', 'v': 'move selected lines down'},
    \ ' ': {'n': 'add blank line below'},
    \ 'f': {'n': 'next file in directory'},
    \ 'n': 'next SCM conflict',
    \ ']': {'n': 'next function or class'},
    \ 'c': {'n': 'next git hunk'},
    \ '%': 'which_key_ignore',
\}
let s:map_sqc.o = copy(s:unimpaired_bindings)
let s:map_sqc.o.n.name = '+disable'

let s:map_g = {
    \ 'c': 'comment [m]',
    \ 'cc': {'n': 'comment line'},
    \ 's': {'n': 'sort [m]', 'v': 'sort selected lines'},
    \ 'ss': {'n': 'sort [c] lines'},
    \ 'A': {'n': 'show conersions for number under cursor', 'v': 'show conversions for selected number'},
    \ 'S': {'v': 'surround selection with [...] and wrap'},
    \ '%': 'which_key_ignore',
\}


" function! s:custom_which_key_format(key)
"   TODO truncate to 20 chars or so
" endfunction

" let g:WhichKeyFormatFunc = function('s:custom_which_key_format')

command! -bang -nargs=1 WhichKeyOperatorPending2 call s:whichkey_o(<args>)
function! s:whichkey_o(runtime)
    call which_key#start(0, 1, a:runtime)
endfunction
