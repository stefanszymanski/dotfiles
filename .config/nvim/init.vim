" Load plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')
    " libraries
    Plug 'tpope/vim-repeat'
    Plug 'glts/vim-magnum'

    " basic editing
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'christoomey/vim-sort-motion'
    Plug 'inkarkat/vim-ReplaceWithRegister'
    Plug 'tpope/vim-unimpaired'

    " theme and visualization
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'morhetz/gruvbox'
    Plug 'ryanoasis/vim-devicons'
    Plug 'nathanaelkane/vim-indent-guides'

    " fancy start screen
    Plug 'mhinz/vim-startify'

    " tmux integration
    Plug 'christoomey/vim-tmux-navigator'

    " version control
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " project management
    " Plug 'airblade/vim-rooter'
    Plug 'vim-scripts/autocwd.vim'

    " searching and file browsing
    Plug 'Shougo/denite.nvim'
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
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'

    " unix shell commands
    Plug 'tpope/vim-eunuch'

    " undo history
    Plug 'mbbill/undotree'

    " auto linting
    "Plug 'w0rp/ale'

    " syntax highlighting
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-scripts/icalendar.vim'

    " natural language
    " Plug 'rhysd/vim-grammarous'
    
    " editor config
    Plug 'editorconfig/editorconfig-vim'
    
    " PHP language support
    Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
    Plug 'Rican7/php-doc-modded', {'for': 'php'}

    " Language documentation integration
    Plug 'Shougo/echodoc.vim'

    " COC language server
    function! CocSetup(info)
        call coc#util#install()
        if a:info.status == 'installed' || a:info.force
            call coc#add_extension('coc-css', 'coc-highlight', 'coc-html',
                \ 'coc-json', 'coc-prettier', 'coc-python', 'coc-stylelint', 'coc-phpls',
                \ 'coc-tslint', 'coc-tsserver', 'coc-yaml', 'coc-vimlsp', 'coc-xml', 'coc-lists')
        else
            execute 'CocUpdateSync'
        endif
    endfunction
    Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release', 'do': function('CocSetup')}

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

" autocwd
let g:autocwd_patternwd_pairs = [['*/.config/*', '~/.config'], ['*', '*REPO*']]

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" undotree
let g:undotree_SplitWidth = 55
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" gitgutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
nnoremap <silent> yoG :GitGutterLineHighlightsToggle<CR>

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

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


" Key bindings

" Delete without yanking
nmap <silent> x "_d
xmap <silent> x "_d
nmap <silent> xx "_dd
nmap <silent> xX 0"_d$
nmap <silent> X "_D
xmap <silent> X "_D


" Syntax highlighting

autocmd! BufRead,BufNewFile *.ics setfiletype icalendar


" Diff view
if &diff
    highlight! link DiffText MatchParen
endif
