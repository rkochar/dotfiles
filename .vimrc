" Plugins and syntax highlighting {{{
" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Load plugins here (pathogen or vundle), added my own and it works
" Uncomment this to load plugins
so ~/.vim/plugins.vim

" Turn on syntax highlighting
" syntax on
set re=0 " https://github.com/prabirshrestha/vim-lsp/issues/786#issuecomment-1333947331

" For plugins to load correctly
filetype plugin indent on
" TODO: Needed?
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

" https://stackoverflow.com/a/58514774/12555857
nnoremap <leader>F :setlocal foldexpr=(getline(v:lnum)=~@/)?0:1 foldmethod=expr foldlevel=0 foldcolumn=2 foldminlines=0<CR><CR>
nnoremap <leader>f :setlocal foldexpr=(getline(v:lnum)=~@/)?1:0 foldmethod=expr foldlevel=0 foldcolumn=2 foldminlines=0<CR><CR>
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

" stackoverflow.com/a/6053341
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

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

" https://www.imaginaryrobots.net/posts/2021-04-17-converting-vimrc-to-lua/
lua << EOF
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
EOF

" https://github.com/arecarn/vim-fold-cycle
" Won't close when max fold is opened
let g:fold_cycle_toggle_max_open  = 0
" Won't open when max fold is closed
let g:fold_cycle_toggle_max_close = 0

set foldopen=block,hor,mark,percent,search,tag,undo,jump
set foldlevel=20

lua << EOF
vim.api.nvim_create_autocmd({ "FileType" }, {
    callback = function()
    -- check if treesitter has parser 
    if require("nvim-treesitter.parsers").has_parser() then

        -- use treesitter folding
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
        -- use alternative foldmethod
        -- vim.opt.foldmethod = "syntax"
        vim.opt.foldmethod = "indent"
        end
        end,
})
EOF

" Folding https://learnvimscriptthehardway.stevelosh.com/chapters/18.html
" use za with {{{ and }}} to fold
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim set foldlevel=0
augroup END

" https://github.com/pseewald/vim-anyfold
" disable anyfold for large files
let g:LargeFile = 1000000 " file is large if size greater than 1MB
autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
function LargeFile()
    augroup anyfold
        autocmd! " remove AnyFoldActivate and hopefully the callback function
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
" inoremap kj <esc>:x<cr>
inoremap <esc> <nop>

set noswapfile
" }}}

" Copy and paste {{{
" paste https://stackoverflow.com/a/2514520/12555857
" set pastetoggle=<leader>p

" https://stackoverflow.com/questions/76687544/emulate-pastetoggle-in-neovim
nnoremap <silent> <leader>p :set paste!<cr>
inoremap <silent> <leader>p <esc>:set paste!<cr>i

nnoremap <leader>c :set clipboard+=unnamedplus

" Paste at cursor and move cursor to end of pasted text https://unix.stackexchange.com/a/5061/570671
noremap p gP
" Ctrl+d to delete line in insert mode
inoremap <c-d> <esc>ddi

" " TODO: Recheck this code block
" " in parenthesis https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
" " p is mapped to toggle paste
" " onoremap p i(
" 
" " Set paste on entering visual mode
" "augroup VisualEvent
" "    autocmd!
" "    autocmd ModeChanged *:[vV\x16]* 
" "    autocmd ModeChanged [vV\x16]*:* 
" "augroup END
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
let g:rust_fold = 2

inoremap <leader>? {:?}
inoremap <leader>(' ('')<ESC>F'i
inoremap <leader>{' {''}<ESC>F'i
inoremap <leader>(" ("")<ESC>F"i
inoremap <leader>{" {""}<ESC>F"i
inoremap <leader>b" !("");<ESC>F"i
inoremap (<CR> (<CR>)<C-o>O
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (" ("")<C-o>h
inoremap {" {""}<C-o>h
inoremap [" [""]<C-o>h

" zsh syntax highlighting. TODO: Find it a place to live.
autocmd BufNewFile,BufRead manjaro-zsh-config set syntax=zsh

augroup rust
    autocmd!
    autocmd FileType rust nnoremap <buffer> <leader>rf :RustFmt<CR>
augroup END

" Rust analyzer {{{
lua << EOF
local lspconfig = require'lspconfig'

local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.rust_analyzer.setup({
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
EOF
" }}}

" lsp diagnostic {{{
nnoremap <silent> <leader>e <cmd>lua vim.diagnostic.open_float()<CR>
" 2 is ideal, for gitsigns and for lsp but they do not seem to be behaving and instead widen the gutter by a large amount.
set signcolumn=auto:1

" https://github.com/neovim/neovim/issues/26685
lua << EOF
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		enable = true,
		text = {
			["ERROR"] = signs.Error,
			["WARN"] = signs.Warn,
			["HINT"] = signs.Hint,
			["INFO"] = signs.Info,
		},
		texthl = {
			["ERROR"] = "DiagnosticDefault",
			["WARN"] = "DiagnosticDefault",
			["HINT"] = "DiagnosticDefault",
			["INFO"] = "DiagnosticDefault",
		},
		numhl = {
			["ERROR"] = "DiagnosticDefault",
			["WARN"] = "DiagnosticDefault",
			["HINT"] = "DiagnosticDefault",
			["INFO"] = "DiagnosticDefault",
		},
		severity_sort = true,
	},
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
})
EOF
" }}}
" }}}

" Surround {{{
let g:surround_insert_space_left = 0
let g:surround_insert_space_right = 1
"}}}

" Nerdtree {{{
" " https://github.com/preservim/nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
augroup NERDTree
    autocmd!

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup END

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

" Gitsigns {{{
lua << EOF
require('gitsigns').setup({
on_attach = function(bufnr)
local gitsigns = require('gitsigns')

local function map(mode, l, r, opts)
opts = opts or {}
opts.buffer = bufnr
vim.keymap.set(mode, l, r, opts)
end

-- Navigation
map('n', ']c', function()
if vim.wo.diff then
    vim.cmd.normal({']c', bang = true})
else
    gitsigns.nav_hunk('next')
    end
    end)

    map('n', '[c', function()
    if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
    else
        gitsigns.nav_hunk('prev')
        end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)

        map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hi', gitsigns.preview_hunk_inline)

        map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
        end)

        map('n', '<leader>hd', gitsigns.diffthis)

        map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
        end)

        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
        map('n', '<leader>hq', gitsigns.setqflist)

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>td', gitsigns.toggle_deleted)
        map('n', '<leader>tw', gitsigns.toggle_word_diff)

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
        end
})
EOF
"}}}

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

    " Treesitter syntax highlight {{{
lua << EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "rust", "go", "python", "bash", "markdown", "vim", "lua", "json", "yaml", "dockerfile", "regex" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
                end
                end,
                additional_vim_regex_highlighting = false,
                indent = {
                    enable = true
                },
        },
        textobjects = {  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects?search=1#textobjects-lsp-interop
            lsp_interop = {
                enable = true,
                border = 'none',
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>dF"] = "@class.outer",
                },
            },
        },
    }
EOF
    " }}}

    " Treesitter object select {{{
lua <<EOF
    require'nvim-treesitter.configs'.setup {
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    -- You can optionally set descriptions to the mappings (used in the desc parameter of
                    -- nvim_buf_set_keymap) which plugins like which-key display
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    -- You can also use captures from other query groups like `locals.scm`
                    ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>', -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true or false
                include_surrounding_whitespace = true,
            },
            },
    }
EOF
    " }}}

    " Treesitter object swap {{{
lua <<EOF
    require'nvim-treesitter.configs'.setup {
        textobjects = {
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>s"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>S"] = "@parameter.inner",
                },
            },
            },
    }
EOF
    " }}}

    " Treesitter object move {{{
lua <<EOF
    require'nvim-treesitter.configs'.setup {
        textobjects = {
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = { query = "@class.outer", desc = "Next class start" },
                    --
                    -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
                    ["]o"] = "@loop.*",
                    -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                    --
                    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                    ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
                    ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
                -- Below will go to either the start or the end, whichever is closer.
                -- Use if you want more granular movements
                -- Make it even more gradual by adding multiple queries and regex.
                goto_next = {
                    ["]d"] = "@conditional.outer",
                },
                goto_previous = {
                    ["[d"] = "@conditional.outer",
                }
                },
            },
    }
EOF
    " }}}

    " Treesitter repeat {{{
     " -- example: make gitsigns.nvim movement repeatable with ; and , keys.
lua <<EOF
--     local gs = require("gitsigns")
--
--     -- make sure forward function comes first
--     local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
--     -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
--
--     vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat)
--     vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat)

    -- Repeat
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
EOF
    " }}}

    " Color scheme (terminal/vim) {{{
    set background=dark
    " colorscheme PaperColor
    colorscheme PaperColorSlim


    let g:brightest#highlight = {
                \   "group" : "BrightestUnderline"
                \}

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

lua << EOF
    require('beacon').setup()
EOF
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
    set statusline+=%{GitStatus()}
    " }}}
