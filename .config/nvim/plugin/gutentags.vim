if (&runtimepath =~ '/plugged/vim-gutentags/') == 0
    finish
endif


let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_project_root = ['.git', '.svn']

let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_ctags_tagfile = '.ctags'
let g:gutentags_scopefile = '.cscope'

let g:gutentags_resolve_symlinks = 0
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" load additional ctags arguments from file
let g:gutentags_ctags_extra_args = ['--options=~/.ctags.options']

" TODO statusline indicator when gutentags is indexing
