" Load plugins with vim-plug

call plug#begin('~/.local/share/nvim/plugged')

" theme
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
" tmux integration
Plug 'christoomey/vim-tmux-navigator'
" version control
Plug 'tpope/vim-fugitive'
" fzf integration
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" git integration
Plug 'tpope/vim-fugitive'

call plug#end()


" Encoding

set encoding=utf-8  		    " The encoding displayed.
set fileencoding=utf-8 		    " The encoding written to file.
scriptencoding utf-8


" General behaviour

syntax enable
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
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nofoldenable                " Auto fold code
set mouse=a                     " Automatically enable mouse usage
set mousehide                   " Hide the mouse cursor while typing
set modeline                    " Enable modeline


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

nnoremap <leader>s :set invspell<CR>    " Toggle spell checking


" Plugin vim-airline

let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
let g:airline_solarized_bg='dark'

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_close_button = 0


" Diff view
if &diff
    highlight! link DiffText MatchParen
endif

