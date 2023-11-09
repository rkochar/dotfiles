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

" https://stackoverflow.com/a/7912621/12555857
set splitright
set splitbelow

" Cursor motion
set cursorline " Highlight line
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

" Closing bracket https://stackoverflow.com/a/34992101/12555857
"inoremap " ""<left>
"inoremap "" ""<left>
"inoremap ' ''<left>
"inoremap '' ''<left>
"inoremap ( ()<left>
"inoremap () ()<left>
"inoremap [ []<left>
"inoremap [] []<left>
"inoremap { {}<left>
"inoremap {} {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {<CR>} {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" switch n and N consistently https://stackoverflow.com/a/25740547/12555857
noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

" paste https://stackoverflow.com/a/2514520/12555857
set pastetoggle=<leader>p

" relative number
" Toggle relative line number
nmap <C-L> :set invrelativenumber<CR>

" Paste at cursor and move cursor to end of pasted text https://unix.stackexchange.com/a/5061/570671
noremap p gP

" Nerdtree
" https://github.com/preservim/nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Show hidden files
let NERDTreeShowHidden=1

" https://github.com/Xuyuanp/nerdtree-git-plugin
let g:NERDTreeGitStatusUseNerdFonts = 0 " default: 0 (false) " TODO: nerdfont not installed (correctly)
let g:NERDTreeGitStatusShowClean = 1 " default: 0
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0

" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreeLimitedSyntax = 1

" https://github.com/PhilRunninger/nerdtree-visual-selection#configuration
let g:nerdtree_vis_jumpmark = 'p' " default: 'n'

" Fugitive
" Clean buffer on closing vim
autocmd BufReadPost fugitive://* set bufhidden=delete

" Add git branch to statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Maps Tab to go back in Gedit
autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> <Tab> :edit %:h<CR> |
  \ endif


" CtrlP
" Search includes hidden files
let g:ctrlp_show_hidden = 1
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlPRoot'

" https://github.com/kien/ctrlp.vim/issues/650#issuecomment-101752106
"let g:ctrlp_prompt_mappings = { 
"    \ 'AcceptSelection("h")': ['<c-h>'],
"    \ 'PrtCurLeft(): ['<c-x>'],
"    \  }

" Color scheme (terminal)
" set t_Co=256
set background=dark
" let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

" Vim color from https://github.com/branwright1/salvation-vim
set termguicolors
" colorscheme salvation
colorscheme PaperColor

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


