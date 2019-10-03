let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['readonly', 'bufnum', 'cwd', 'relativepath', 'spell', 'modified'],
    \             ['gitbranch']
    \   ],
    \   'right': [ ['percent', 'lineinfo'],
    \              ['fileformat', 'fileencoding', 'filetype']
    \   ],
    \ },
    \ 'tabline': {
    \   'left': [ ['tabs'] ],
    \   'right': [ ['close'] ],
    \ },
    \ 'tab': {
    \   'active': ['tabnum', 'relativepath', 'modified'],
    \   'inactive': ['tabnum', 'filename', 'modified']
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'cwd': 'LightlineCwd',
    \ }
    \ }

function! LightlineCwd()
    return fnamemodify(getcwd(), ':~')
endfunction
