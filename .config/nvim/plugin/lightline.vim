let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['readonly', 'bufnum', 'relativepath', 'spell', 'modified', 'cocstatus'],
    \             ['gitbranch'],
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
    \   'cocstatus': 'coc#status',
    \ }
    \ }

function! LightlineCwd()
    return fnamemodify(getcwd(), ':~')
endfunction
