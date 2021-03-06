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
" [m]   motion
" (wuc) word under cursor
" (suc) symbol under cursor (LSP)
" (uc)  under cursor
" [n]   number
" [c]   character

let s:map_leader = {
    \ 'u': {'n': 'toggle Mundo buffer'},
    \ 'n': {'n': 'toggle Nerdtree'},
    \ 'N': {'n': 'open Nerdtree on current file'},
    \ 'y': 'yield to system clipboard',
    \ 'p': 'paste from system clipboard',
\ }

let s:map_leader.b = { 'n': {
    \ 'name': '+buffers',
    \ 'b': 'list',
    \ 'a': 'switch to alternate',
    \ 'd': 'delete current',
    \ 'D': 'delete all',
    \ 'o': 'delete others',
    \ 'O': 'wipeout others',
    \ 'p': 'replace with clipboard',
    \ 'W': 'wipeout all',
    \ 'w': 'wipeout current',
    \ 'y': 'yank',
\ }}

let s:map_leader.w = { 'n': {
    \ 'name': '+windows',
    \ 'o': 'close others',
    \ 'w': 'list',
\ }}

let s:map_leader.h = {
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

let s:deploy_bindings = { 'n': {
    \ 't': 'current file, silent',
    \ 'T': 'current file',
    \ 'a': 'all files, silent',
    \ 'A': 'all files',
    \ 'c': 'changed files, silent',
    \ 'C': 'changed files',
\ }}
let s:map_leader.d = deepcopy(s:deploy_bindings)
let s:map_leader.d.n.name = '+deploy'
let s:map_leader.d.n.f = 'select files, silent'
let s:map_leader.d.n.F = 'select files'
let s:map_leader.D = deepcopy(s:deploy_bindings)
let s:map_leader.D.n.name = '+deploy-default'

let s:map_leader.m = { 'n': {
    \ 'name': '+make',
    \ 'r': 'show results',
    \ 'R': 'show results with catch-all parser',
    \ 'a': 'abort most recent build',
\ }}

let s:map_leader.l = {
\ 'name': '+language',
    \ 'c': {'n': 'list references of (suc)'},
    \ 'j': {'n': 'jump to definition of (suc)'},
    \ 'i': {'n': 'list implementations of (suc)'},
    \ 'r': {'n': 'rename (suc)'},
    \ 't': {'n': 'show type definition of (suc)'},
    \ 'l': {'n': 'show documentation of (suc)'},
    \ 'D': {'n': 'jump to declaration of (suc)'},
    \ 'R': {'n': 'open refactoring buffer'},
    \ 'f': {'n': 'format [m]', 'v': 'format selection'},
    \ 'F': {'n': 'format buffer'},
    \ 'o': {'n': 'search outline'},
    \ 'O': {'n': 'show outline'},
    \ 's': {'n': 'search symbols'},
    \ 'C': {'n': 'resume latest search'},
    \ 'd': {'n': 'list errors and warnings'},
\ }

let s:map_leader.s = {
    \ 'name': '+search',
    \ 't': {'n': 'tags in buffer'},
    \ 'l': {'n': 'lines in buffer'},
    \ 'f': {'n': 'files in project'},
    \ 'F': {'n': 'files in project uncached'},
    \ 'T': {'n': 'tags in project'},
    \ 'g': 'grep',
    \ 'G': 'grep uncached',
    \ 'i': {'n': 'grep in directory'},
    \ 'w': {'n': 'grep (wuc)'},
    \ 'W': {'n': 'grep (wuc) uncached'},
    \ 's': {'n': 'search history'},
    \ 'c': {'n': 'command history'},
    \ 'r': {'n': 'recent files'},
    \ 'y': {'n': 'yanks'},
    \ 'j': {'n': 'jumps'},
    \ 'm': {'n': 'marks'},
    \ 'q': {'n': 'quickfixes'},
\ }

let s:map_leader.g = {
    \ 'name': '+git',
    \ 'b': {'n': 'blame line (uc)'},
    \ 's': {'n': 'stage file'},
    \ 'u': {'n': 'unstage file'},
    \ 'U': {'n': 'unstage all files'},
    \ 'C': {'n': 'commit'},
    \ 'd': {'n': 'diff in split window'},
    \ 'B': {'n': 'blame all lines'},
    \ 'l': {'n': 'log', 'v': 'log'},
    \ 'L': {'n': 'log for current file'},
    \ 'r': {'n': 'revisions of current file', 'v': 'revisions'},
    \ 'S': {'n': 'status'},
    \ 'p': {'n': 'pulll'},
    \ 'P': {'n': 'push'},
    \ 'f': {'n': 'changed files'},
\ }

let s:map_leader.g.h = {
    \ 'name': '+hunk',
    \ 's': 'stage hunk (uc)',
    \ 'u': {'n': 'undo hunk (uc)'},
    \ 'p': {'n': 'preview hunk (uc)'},
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
    \ 's': 'surround [m] with [c]',
    \ 'S': 'surround [m] and wrap with [c]',
    \ 'Ss': 'surround line with [c] and wrap',
    \ 'ss': 'surround line with [c]',
\}
let s:map_y.o = copy(s:unimpaired_bindings)
let s:map_y.o.n.name = '+toggle'

" TODO add some core bindings
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
    \ 'd': {'n': 'previous error or warning'},
    \ 'D': {'n': 'previous error'},
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
    \ 'd': {'n': 'next error or warning'},
    \ 'D': {'n': 'next error'},
    \ '%': 'which_key_ignore',
\}
let s:map_sqc.o = copy(s:unimpaired_bindings)
let s:map_sqc.o.n.name = '+disable'

" Mark [n] in gss different because it's a count before the binding
let s:map_g = {
    \ 'c': 'comment [m]',
    \ 'cc': {'n': 'comment line'},
    \ 's': {'n': 'sort [m]', 'v': 'sort selected lines'},
    \ 'ss': {'n': 'sort [n] lines'},
    \ 'A': {'n': 'show conversions for number (uc)', 'v': 'show conversions for selected number'},
    \ 'S': {'v': 'surround selection with [...] and wrap'},
    \ '8': {'n': 'show UTF8 hey value of (cuc)'},
    \ 'J': {'n': 'join [n=2] lines without fixing spacing'},
    \ 'P': {'n': 'paste before cursor'},
    \ 't': {'n': 'goto next tab'},
    \ 'T': {'n': 'goto previous tab'},
    \ 'f': {'n': 'edit file whose name is (uc)'},
    \ 'F': {'n': 'like gf but also jump to line'},
    \ 'g': {'n': 'goto top of file', 'v': 'select to top of file'},
    \ 'i': {'n': 'edit where last left editing'},
    \ 'q': {'n': 'format [m]', 'v': 'format selection'},
    \ 'r': {'n': 'replace (cuc) with [c]'},
    \ 'u': {'n': 'lowercase [m]', 'v': 'lowercase selection'},
    \ 'U': {'n': 'uppercase [m]', 'v': 'uppercase selection'},
    \ 'v': {'n': 'reselect previous visual selection', 'v': 'exchange current and previous selection'},
    \ 'w': {'n': 'format [m] and keep cursor'},
    \ '%': 'which_key_ignore',
\}


" function! s:custom_which_key_format(key)
"   TODO truncate to 20 chars or so
" endfunction

" let g:WhichKeyFormatFunc = function('s:custom_which_key_format')
