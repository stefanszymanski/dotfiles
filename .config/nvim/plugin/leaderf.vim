let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_WorkingDirectoryMode = "Ac"

let g:Lf_ShortcutF = 0
let g:Lf_ShortcutB = 0

let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg', '.idea', '.project'],
    \ 'file': ['*.sw?','~$*','*.bak', '*.tmp', '*.temp', 'tags']
    \}

let g:Lf_RgConfig = [
    \ "--glob=!git/*",
    \ "--glob=!tags",
    \ "--glob=!.svn/",
    \ "--glob=!.idea/*",
    \ ]

" === Bindings ===
"   <leader>/    - Grep in CWD
"   <leader>fc   - Continue last grep
"   <leader>ff   - Browse files
"   <leader>fr   - Browse recent files
"   ;            - Browse buffers
nnoremap <leader>/   :call <SID>rgInteractive()<CR>
nnoremap <leader>fc  :<C-u>Leaderf rg --recall --fullScreen<CR>
nnoremap <leader>ff  :<C-u>Leaderf file --fullScreen<CR>
nnoremap <leader>fr  :<C-u>Leaderf mru --cwd --fullScreen<CR>
nnoremap ;           :<C-u>Leaderf buffer<CR>

" Modified version of `leaderf#Rg#Interactive`
" Doesn't adds a glob argument when the user enters '*'.
" Otherwise `--glob=*` would override all previous globs.
" TODO find a way to not override previouly defined globs.
function! s:rgInteractive()
    try
        echohl Question
        let pattern = input("Search pattern: ")
        let glob = input("Search in files(e.g., *.c, *.cpp): ", "*")
        if glob =~ '^\s*$'
            return
        endif
        if glob == '*'
            let globs = ''
        else
            let globList = map(split(glob, '[ ,]\+'), 'v:val =~ ''^".*"$'' ? v:val : ''"''.v:val.''"''')
            let globs = '-g ' . join(globList, ' -g ')
        endif
        exec printf("Leaderf rg %s%s %s", pattern =~ '^\s*$' ? '' : '-e ', pattern, globs)
    finally
        echohl None
    endtry
endfunction
