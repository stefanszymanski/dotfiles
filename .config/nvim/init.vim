" Load plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')
    " libraries
    Plug 'tpope/vim-repeat'
    Plug 'glts/vim-magnum'
    Plug 'seletskiy/vim-pythonx'

    " basic editing
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'christoomey/vim-sort-motion'
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-unimpaired'

    " theme and visualization
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'morhetz/gruvbox'
    Plug 'ryanoasis/vim-devicons'
    Plug 'nathanaelkane/vim-indent-guides'

    " tmux integration
    Plug 'christoomey/vim-tmux-navigator'

    " version control
    " Plug 'tpope/vim-fugitive'
    Plug 'jreybert/vimagit'
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim'

    " project management
    Plug 'tpope/vim-projectionist'
    " Plug 'tpope/vim-obsession'
    Plug 'mhinz/vim-startify'

    " searching and file browsing
    " Plug 'Shougo/denite.nvim'
    Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
    Plug 'scrooloose/nerdtree'
    "Plug 'tpope/vim-vinegar'

    " value manipulation and conversion
    Plug 'glts/vim-radical'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-abolish'
    Plug 'arthurxavierx/vim-caser'

    " text objects and motions
    Plug 'bkad/CamelCaseMotion'
    Plug 'michaeljsmith/vim-indent-object'
    " Plug 'vim-scripts/argtextobj.vim'
    Plug 'wellle/targets.vim'
    Plug 'machakann/vim-textobj-functioncall'

    " auto close (quotes, braces, tags, ...)
    Plug 'tmsvg/pear-tree'
    Plug 'alvan/vim-closetag'

    " unix shell commands
    Plug 'tpope/vim-eunuch'

    " undo history
    Plug 'simnalamburt/vim-mundo'

    " snippets
    Plug 'SirVer/ultisnips'

    " syntax highlighting
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-scripts/icalendar.vim'

    " LaTeX
    Plug 'lervag/vimtex'

    " natural language
    " Plug 'rhysd/vim-grammarous'
    
    " editor config
    Plug 'editorconfig/editorconfig-vim'

    " tags
    Plug 'ludovicchabant/vim-gutentags'

    " Language documentation integration
    Plug 'Shougo/echodoc.vim'

    " COC language client
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
call plug#end()



" Encoding
set encoding=utf-8  		    " The encoding displayed.
set fileencoding=utf-8 		    " The encoding written to file.
scriptencoding utf-8


" General behaviour

syntax enable
let mapleader=" "
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nofoldenable                " Auto fold code
set mouse=a                     " Automatically enable mouse usage
set mousehide                   " Hide the mouse cursor while typing
set modeline                    " Enable modeline
set updatetime=300
set cmdheight=2                 " Display the command bar 2 lines height
set hidden                      " Allow hiding modified buffers
set confirm                     " Ask for confirmation when closing a modified buffer
set shortmess+=c
set signcolumn=yes              " Always display the sign column
set relativenumber              " Use relative line numbers
set exrc

set nocompatible
filetype plugin on

set path+=**
set wildmenu


let g:python3_host_prog = '~/.virtualenvs/nvim3/bin/python'
" let g:python_host_prog = '~/.virtualenvs/nvim2/bin/python'


" Misc

" let g:netrw_liststyle = 3       " Tree style file browser
" let g:netrw_banner = 0          " Remove those information that are shown above the file list
" let g:netrw_browse_split = 4    " Open in vertical split
" let g:netrw_altv = 1
" let g:netrw_winsize = 20
" let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'


" Plugins

let g:titlecase_map_keys = 0    " Disable default mappings
let g:camelcasemotion_key = '<leader>'
let g:abolish_no_mappings = 1   " Disable coercion mappings from tpope/vim-abolish
let g:caser_prefix = '<leader>gs'

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" mundo
nnoremap <silent> <leader>u :MundoToggle<CR>
let g:mundo_width = 55
let g:mundo_preview_height = 40
let g:mundo_right = 1
let g:mundo_preview_bottom = 1

" gitgutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
nnoremap <silent> yoG :GitGutterLineHighlightsToggle<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<c-q>"
let g:UltiSnipsJumpForwardTrigger="<c-v>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" gutentags
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" COC language client
let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-vimtex',
    \ 'coc-json', 'coc-prettier', 'coc-python', 'coc-stylelint',
    \ 'coc-phpls', 'coc-tslint', 'coc-tsserver', 'coc-yaml',
    \ 'coc-vimlsp', 'coc-xml', 'coc-ultisnips', 'coc-lists']

" obsession
" let g:obsession_no_bufenter = 1
" let g:session_dir = '~/.vim-sessions/'
" exec 'nnoremap <Leader>ss :Obsession ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS><BS>'
" exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS><BS>'
" nnoremap <Leader>sp :Obsession<CR>

" startify
let g:startify_session_dir = '~/.vim-sessions'
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']       },
    \ ]


" grammarous
" let g:grammarous#use_vim_spelllang = 1
" let g:grammarous#use_location_list = 1
" let g:grammarous#show_first_error = 1
" let g:grammarous#default_comments_only_filetypes = {'*': 1, 'help': 0, 'markdown': 0, 'mail': 0}
" let g:grammarous#hooks = {}
" function! g:grammarous#hooks.on_check(errs) abort
"     nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
"     nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
" endfunction
" function! g:grammarous#hooks.on_reset(errs) abort
"     nunmap <buffer><C-n>
"     nunmap <buffer><C-p>
" endfunction



" Theme

set background=dark
colorscheme gruvbox
let gruvbox_contrast_dark='medium'

set fillchars+=vert:│                               " Vertical split view divider
highlight EndOfBuffer ctermfg=black ctermbg=black   " Hide empty line indicator ~


" Formatting

set wrap                        " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use auto indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
"set cc=80                       " set an 80 column border for good coding style


" Additional Key bindings

" Delete without yanking
nmap <silent> <leader>d "_d
xmap <silent> <leader>d "_d
nmap <silent> <leader>dd "_dd
nmap <silent> <leader>D "_D
xmap <silent> <leader>D "_D
" Change without yanking
nmap <silent> <leader>c "_c
xmap <silent> <leader>c "_c
nmap <silent> <leader>cc "_cc
nmap <silent> <leader>C "_C
xmap <silent> <leader>C "_C


" Shadowing Key bindings

" Delete character without yanking
nnoremap <silent> x "_x
xnoremap <silent> x "_x
nnoremap <silent> X "_X
xnoremap <silent> X "_X
" Change character without yanking
nnoremap <silent> s "_s
xnoremap <silent> s "_s
nnoremap <silent> S "_S
xnoremap <silent> S "_S


" Diff view
if &diff
    highlight! link DiffText MatchParen
endif
