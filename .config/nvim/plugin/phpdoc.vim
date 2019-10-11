" === Configuration for plugin php-doc-modded === "
"   Github: https://github.com/Rican7/php-doc-modded


" === General settings === "

" Do not add a comment behind a method or class
let g:pdv_cfg_autoEndFunction = 0
let g:pdv_cfg_autoEndClass = 0

" No PHP4 stuff
let g:pdv_cfg_php4always = 0
let g:pdv_cfg_php4guessval = 0

" Class tags
let g:pdv_cfg_createClassTags = 1
let g:pdv_cfg_Uses = 0
let g:pdv_cfg_annotation_Author = 1
let g:pdv_cfg_annotation_Package = 0
let g:pdv_cfg_annotation_Version = 0
let g:pdv_cfg_annotation_Copyright = 0
let g:pdv_cfg_annotation_License = 0

" Annotation default values
let g:pdv_cfg_Author = "Stefan Szymanski <stefan.szymanski@form4.de>"


" === Bindings === "

"  <Leader>rcd   - Create PHPDoc for symbol under cursor
nnoremap <Leader>gpd :call UpdatePhpDocIfExists()<CR>


" === Helper functions === "

" Create new or update existing PHPDoc
function! UpdatePhpDocIfExists()
    normal! k
    if getline('.') =~ '/'
        normal! V%d
    else
        normal! j
    endif
    call PhpDocSingle()
    normal! k^%k$
    if getline('.') =~ ';'
        exe "normal! $svoid"
    endif
endfunction
