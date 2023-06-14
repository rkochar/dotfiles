" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Load plugins here (pathogen or vundle), added my own and it works
" Uncomment this to load plugins
so ~/.vim/plugins.vim

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader = "\\"

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
" set visualbell
" Disable all light flashes
set belloff=all

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=250
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" paste https://stackoverflow.com/a/2514520/12555857
set pastetoggle=<leader>p

" Color scheme (terminal)
" set t_Co=256
" set background=dark
" let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

" Vim color from https://github.com/branwright1/salvation-vim
set termguicolors
" colorscheme salvation
" colorscheme palenight
" colorscheme papaya
colorscheme jellybeans


" CURSOR

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[5 q"

" LIGHTLINE GIT

" Lightline
let g:lightline = {
  \ 'active': {
  \ 'left': [['mode', 'paste'],
  \    ['gitbranch', 'readonly', 'filename', 'modified']],
  \ 'right': [['lineinfo'],
  \    ['percent'],
  \    ['fileformat', 'fileencoding']]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ }
clear


