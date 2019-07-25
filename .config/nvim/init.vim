" Load plugins with vim-plug

call plug#begin('~/.local/share/nvim/plugged')

" theme
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
" tmux integration
Plug 'christoomey/vim-tmux-navigator'
" version control
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" fzf integration
"Plug '~/.fzf'
"Plug 'junegunn/fzf.vim'
" Fuzzy file finding, file management, project searching
Plug 'Shougo/denite.nvim'
" auto linting
"Plug 'w0rp/ale'
" syntax highlighting
Plug 'sheerun/vim-polyglot'
" fancy start screen
Plug 'mhinz/vim-startify'

" PHP language support
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'Rican7/php-doc-modded', {'for': 'php'}

" COC language server
function! CocSetup(info)
  " Initial setup
  call coc#util#install()
  " Install extensions on installation, update otherwise
  if a:info.status == 'installed' || a:info.force
    call coc#add_extension('coc-css', 'coc-highlight', 'coc-html', 'coc-json', 'coc-prettier', 'coc-python', 'coc-stylelint', 'coc-tslint',
        \ 'coc-tsserver', 'coc-ultisnips', 'coc-yaml', 'coc-vimlsp', 'coc-xml', 'coc-lists')
  else
    execute 'CocUpdateSync'
  endif
endfunction

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release', 'do': function('CocSetup')}

call plug#end()

let g:deoplete#enable_at_startup = 1


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
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nofoldenable                " Auto fold code
set mouse=a                     " Automatically enable mouse usage
set mousehide                   " Hide the mouse cursor while typing
set modeline                    " Enable modeline
set updatetime=300
set cmdheight=2                 " Display the command bar 2 lines height
set hidden
set shortmess+=c
set signcolumn=yes              " Always display the sign column


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

for f in ['coc', 'denite', 'airline', 'phpactor', 'phpdoc']
    execute 'source $HOME/.config/nvim/plugins/'.f.'.vim'
endfor


" Key bindings

nnoremap <leader>s :set invspell<CR>    " Toggle spell checking


" Diff view
if &diff
    highlight! link DiffText MatchParen
endif
