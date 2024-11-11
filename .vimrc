" Plugins and syntax highlighting {{{
" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Load plugins here (pathogen or vundle), added my own and it works
" Uncomment this to load plugins
so ~/.vim/plugins.vim

" Turn on syntax highlighting
syntax on
set re=0 " https://github.com/prabirshrestha/vim-lsp/issues/786#issuecomment-1333947331

" For plugins to load correctly
filetype plugin indent on
" set smartindent
" }}}

" leader {{{
let mapleader = "\\"
let maplocalleader = ","
"}}}

" Security
" TODO: What does this do?
set modelines=0

" Whitespace, tab, and line length {{{
set wrap
set showbreak=+++
set textwidth=300
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
noremap <leader>l :set list!<CR> " Toggle tabs and EOL
" }}}

" Cursor, scrolling and brackets {{{
set cursorline " Highlight line
set scrolloff=3
set backspace=indent,eol,start

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Disable nvim mouse settings.
set mouse=r

" Blink cursor on error instead of beeping (grr)
" set visualbell
" Disable all light flashes
set belloff=all

set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim
" }}}

" Status bar {{{
set laststatus=2
" Last line
set showmode
set showcmd
set showtabline=2 " TODO: What does this do?
" }}}

" Searching {{{
" nnoremap / /\v  " These two lines make search case-insensitive but not needed because of ignorecase and smartcase (I think)
" vnoremap / /\v

" switch n and N consistently https://stackoverflow.com/a/25740547/12555857
noremap <expr> n 'Nn'[v:searchforward]
noremap <expr> N 'nN'[v:searchforward]

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
noremap <leader><space> :let @/=''<cr> " clear search
" }}}

" Gutter, panes and buffers {{{
" split in right and down directions https://stackoverflow.com/a/7912621/12555857
set splitright
set splitbelow

" Show line numbers
set number 
" Toggle relative line number
nnoremap <C-L> :set invrelativenumber<CR>
" Show file stats
set ruler

" Rendering https://stackoverflow.com/a/307175
set ttyfast

" Allow hidden buffers
set hidden

noremap <leader>t :sp term://zsh<CR>
"noremap <leader>t call OpenTerminal()<CR>

" Function to check for nvim
function! OpenTerminal()
    command echom "here"
    if has('nvim')
        command Terminal vsplit term://zsh
    else
        command Terminal vert term
    endif
endfunction
" }}}

" Remap help key.
" TODO: What does this do?
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Formatting, indent {{{
" https://stackoverflow.com/questions/67224947/could-someone-provide-a-broken-down-description-for-the-vim-command-gqip
map <leader>j gqip
" Indent before saving files
nnoremap <leader>i gg=G
" Encoding
set encoding=utf-8

" Upper case in insert mode
inoremap <c-u> <esc>veUi

" https://github.com/preservim/vim-indent-guides?tab=readme-ov-file#usage
let g:indent_guides_enable_on_vim_startup = 0
noremap <leader>it :IndentGuidesToggle<CR>

" Folding https://learnvimscriptthehardway.stevelosh.com/chapters/18.html
" use za with {{{ and }}} to fold
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" https://github.com/arecarn/vim-fold-cycle
" Won't close when max fold is opened
let g:fold_cycle_toggle_max_open  = 0
" Won't open when max fold is closed
let g:fold_cycle_toggle_max_close = 0

" https://github.com/pseewald/vim-anyfold
" disable anyfold for large files
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate
        autocmd Filetype <filetype> setlocal foldmethod=indent " fall back to indent folding
    augroup END
endfunction
" }}}

" Save file and quit vim {{{
cnoreabbrev W w
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>xa :xa<CR>
inoremap <leader>x <esc>:x<CR>
inoremap <leader>xa <esc>:xa<CR>
noremap <leader>w <esc>:w<CR>
inoremap <leader>w <esc>:w<CR>
nnoremap <leader>z <c-z>
noremap <leader>z <esc><c-z>

inoremap jk <esc>
inoremap kj <esc>:x<cr>
inoremap <esc> <nop>

set noswapfile
" }}}

" Copy and paste {{{
" paste https://stackoverflow.com/a/2514520/12555857
set pastetoggle=<leader>p

nnoremap <leader>c :set clipboard+=unnamedplus

" Paste at cursor and move cursor to end of pasted text https://unix.stackexchange.com/a/5061/570671
noremap p gP
" Ctrl+d to delete line in insert mode
inoremap <c-d> <esc>ddi

" in parenthesis https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
" p is mapped to toggle paste
" onoremap p i(

" Set paste on entering visual mode
"augroup VisualEvent
"    autocmd!
"    autocmd ModeChanged *:[vV\x16]* 
"    autocmd ModeChanged [vV\x16]*:* 
"augroup END
" }}}

" dotfiles {{{
let VIMRC = "~/.vimrc"
execute "nnoremap <leader>ev :vsplit " . VIMRC . "<cr>"
execute "nnoremap <leader>exv :split " . VIMRC . "<cr>"
execute "nnoremap <leader>sv :source " . VIMRC . "<cr>:q<cr>"
unlet VIMRC

" nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" nnoremap <leader>exv :split $MYVIMRC<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr>:q<cr>

nnoremap <leader>en :vsplit ~/dotfiles/regex.md<cr>
nnoremap <leader>exn :split ~/dotfiles/regex.md<cr>
nnoremap <leader>sn :source ~/dotfiles/regex.md<cr>:q<cr>
" }}}{{{}}}

" rust {{{
let g:rustfmt_autosave = 1

inoremap <leader>? {:?}
inoremap <leader>(' ('')<ESC>F'i
inoremap <leader>(" ("")<ESC>F"i
inoremap <leader>b" !("");<ESC>F"i
inoremap {<CR> {<CR>}<C--o>O

" zsh syntax highlighting. TODO: Find it a place to live.
autocmd BufNewFile,BufRead manjaro-zsh-config set syntax=zsh

nnoremap <silent> <leader>e <cmd>lua vim.diagnostic.open_float()<CR>

augroup rust
    autocmd!
    autocmd FileType rust nnoremap <buffer> <leader>rf :RustFmt<CR>
augroup END
" }}}

" Surround {{{
let g:surround_insert_space_left = 0
let g:surround_insert_space_right = 1
"}}}

" Nerdtree {{{
" " https://github.com/preservim/nerdtree
" nnoremap <leader>n :NERDTreeFocus<CR>
" augroup NERDTree
"     autocmd!
" 
"     " Exit Vim if NERDTree is the only window remaining in the only tab.
"     autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"     " Close the tab if NERDTree is the only window remaining in it.
"     autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"     " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
"     autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" augroup END
" 
" " Show hidden files
" let NERDTreeShowHidden=1
" 
" " https://github.com/Xuyuanp/nerdtree-git-plugin
" let g:NERDTreeGitStatusUseNerdFonts = 0 " default: 0 (false) " TODO: nerdfont not installed (correctly)
" let g:NERDTreeGitStatusShowClean = 1 " default: 0
" let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0
" 
" " https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" let g:NERDTreeLimitedSyntax = 1
" 
" " https://github.com/PhilRunninger/nerdtree-visual-selection#configuration
" let g:nerdtree_vis_jumpmark = 'p' " default: 'n'
" " }}}

" Fugitive {{{
augroup fugitive
    autocmd!
    " Clean buffer on closing vim
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " Maps Tab to go back in Gedit
    autocmd User fugitive 
                \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
                \   nnoremap <buffer> <Tab> :edit %:h<CR> |
                \ endif
augroup END

" Add git branch to statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" https://stackoverflow.com/a/7313949/12555857
" git config --global mergetool.fugitive.cmd 'vim -f -c "Gvdiffsplit!" "$MERGED"'
" git config --global merge.tool fugitive
" }}}

" CtrlP {{{
" Search includes hidden files
let g:ctrlp_show_hidden = 1
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlPRoot'
let g:ctrlp_open_new_file = 'h'
let g:ctrlp_working_path_mode = 'ra'

nnoremap <leader>cp :CtrlPClearCache<CR>

" https://github.com/kien/ctrlp.vim/issues/650#issuecomment-101752106
"let g:ctrlp_prompt_mappings = { 
"    \ 'AcceptSelection("h")': ['<c-h>'],
"    \ 'PrtCurLeft(): ['<c-x>'],
"    \  }
" }}}

" calendar {{{
" calendar https://github.com/itchyny/calendar.vim/blob/master/doc/calendar.txt
let g:calendar_date_endian = "little"
let g:calendar_week_number = 1
let g:calendar_clock_12hour = 0
let g:calendar_cyclic_view = 1
let g:calendar_first_day = "monday"
let g:calendar_google_calendar = 1
let g:calendar_google_task = 0
" https://github.com/itchyny/calendar.vim#important-notice
source ~/.cache/calendar.vim/credentials.vim
" marks: https://github.com/itchyny/calendar.vim/blob/master/doc/calendar.txt#L767
" }}}

" Color scheme (terminal/vim) {{{
" set t_Co=256
set background=dark
set termguicolors

" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

" Vim color from https://github.com/branwright1/salvation-vim
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
" }}}

" Lightline {{{
let g:lightline = {
            \  'colorscheme': 'powerline',
            \ 'active': {
            \ 'left': [['mode', 'paste'],
            \    ['gitbranch', 'readonly', 'filename', 'modified'],
            \    ['gitdelta']],
            \ 'right': [['lineinfo'],
            \    ['percent'],
            \    ['fileformat', 'fileencoding']]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveStatusline',
            \   'gitdelta': 'GitStatus'
            \ },
            \ }

function! GitStatus()
    if !get(g:, 'gitgutter_enabled', 0) || empty(FugitiveHead())
        return ''
    endif
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
se statusline+=%{GitStatus()}
" }}}
