filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 
filetype plugin indent on

set nocompatible
set syntax=on
syntax on
colorscheme desert
let mapleader=','

set visualbell
set cursorline
set ruler
set laststatus=2
set relativenumber
set undofile
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

set autoindent
set smartindent
set smarttab 
set expandtab
set tabstop=2
set shiftwidth=2

set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,latin2,cp1250

set pastetoggle=<f7>

set scrolloff=3
set showmode
set showcmd
set wildmenu
set wildmode=list:longest

" search
set incsearch       "incremental search"
set gdefault
set hlsearch        "high light search"
set ignorecase      "ignore case"
set smartcase       "unless there's mixture of case"
set magic           "magic characters in patterns"
set showmatch
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

" Matching parenthesis
set matchtime=10
nnoremap <tab> %
vnoremap <tab> %

" long lines
set wrap
set formatoptions=qrnl
set colorcolumn=85
nnoremap j gj
nnoremap k gk

" invisible characters
set list
set listchars=tab:▸\ ,eol:¬

" misc
nnoremap ; :
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack 
nnoremap <leader>ft Vatzf
nnoremap <leader>q gqip
nnoremap <leader>v V`]
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
inoremap jj <ESC>
inoremap <F1> <ESC> nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <F2> :NERDTree .<CR>

" multiple buffers
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>ww <C-w>s<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

autocmd FocusLost * :wa

"YankRing
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

nnoremap <leader>u :undolist<cr>

