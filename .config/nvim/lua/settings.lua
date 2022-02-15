vim.cmd [[
    " Encoding
    set encoding=utf-8  		    " The encoding displayed.
    set fileencoding=utf-8 		    " The encoding written to file.

    " General behaviour

    set nocompatible
    filetype plugin on
    syntax enable
    let mapleader=" "
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
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
    set synmaxcol=500               " Restrict syntax highlighting to 500 characters per line
    " set exrc
    set path+=**
    set termguicolors

    " line numbering: relative in active buffer, absolute in inactive buffers
    set number relativenumber
    augroup NumberToggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END

    highlight EndOfBuffer ctermfg=black ctermbg=black   " Hide empty line indicator ~

    " wildmenu in popup
    set wildmenu
    set wildmode=longest:full,full
    set wildoptions=pum

    " disable netrw
    let g:loaded_netrw       = 1
    let g:loaded_netrwPlugin = 1

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
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    "set cc=80                       " set an 80 column border for good coding style

    " Diff view
    if &diff
        highlight! link DiffText MatchParen
    endif
]]
