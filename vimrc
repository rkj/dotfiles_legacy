filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

let g:LargeFile=10

set nocompatible
set syntax=on
syntax on
colorscheme desert
"colorscheme solarized
let mapleader=','

set visualbell
set cursorline
set ruler
set laststatus=2
set relativenumber
set undofile
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set autowrite "before :make

set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set lazyredraw

set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8 ",latin2,cp1250

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

if has("gui_macvim")
  set fuoptions=maxvert,maxhorz "full screenoptions
  au GUIEnter * set fullscreen
endif
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

nnoremap ; :
"remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack
" select last paste
nnoremap <leader>ft Vatzf
" format paragraph
nnoremap <leader>q gqip
" ? :-)
nnoremap <leader>v V`]
" edit VIMRC
nnoremap <leader>ev <C-w>s<C-w>j:e $MYVIMRC<cr>
inoremap jj <ESC>
" F1 -> ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap <F2> :NERDTree .<CR>

" multiple buffers
nnoremap <leader>ww <C-w>s<C-w>j
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

autocmd FocusLost * :wa

"YankRing
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>
let g:yankring_history_dir = '$HOME/.vim'

" paste system clipboard
nnoremap <leader>p "+gp

nnoremap <silent> <F6> :make<cr>
inoremap <silent> <F6> <ESC>:make<cr>

" Undo
nnoremap <leader>u :undolist<cr>
nnoremap <F5> :GundoToggle<CR>
inoremap <F5> :GundoToggle<CR>

" ctags
nnoremap <leader>g :tag
inoremap <F9>:!tags -R .
nnoremap <F9>:!tags -R .

"CommandT
nnoremap <leader>o :CommandT<CR>
nnoremap <F8> :CommandTFlush<CR>
inoremap <F8> <ESC>:CommandTFlush<CR>i
let g:CommandTAcceptSelectionSplitMap = '<C-d>'

"localvimrc
set wildignore+=*.o,*.obj,*.git,tmp,log,_site
let g:localvimrc_ask=0

"backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/tmp

"vimdiff
set diffopt=filler,iwhite,vertical

