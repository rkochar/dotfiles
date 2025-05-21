# List of Useful Commands and Regex
| Tool | CMD | Action |
|-----|---|---|
|docker| docker image rmi $(docker image ls \| tail -n+2 | awk '$1 ~ "ghcr" {print $3}') | cleanup images |
| kubectl | kubectl get service -o=custom-columns=NAME:metadata.name,NAMESPACE:metadata.namespace | Get n,ns of svc |
| kubectl | kubectl get svc --all-namespaces -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}' | Get all port-forward ports |
|bash| unique file extensions `find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`| unique file extensions in a directory |
|docker|docker search --filter is-official=true busybox | search officual busybox images |
|grep| grep -x | Keep these|
|grep| grep -v | Remove these|
|kafka | kafkacat -b <kafka-service>:<port> -L | debug kafka connection |
| exa | ls -s time | sort newest at bottom |
| exa | ls -s newest --reverse | sort newest at top |
| awk | awk 'BEGIN{FS=","}{sum+=$2}END{print sum}' <file> | sum second column of csv ", " |
| awk | tail -n+2 | awk '{print $2}' | skip first line, get 2nd column |
| vim | :verbose set timeout? timeoutlen? ttimeout? ttimeoutlen? | |
| wget | wget -p <path> <url> | Download file to path |
| base64 encode `echo -n "" | base64` (or not) |
| bash | ${dir##*/} | Remove largest amount matching `*/` |
| bash | string=${string%,*} | remove everything , onwards | 
| rg | rg -iF "<exact-match> -g "**/<regex>" | |
| gendates | `function gendates { for dd in $(seq -w $1 $2) ; do date -d $dd +%Y%m%d 2>/dev/null ; done  ; }` log files to check | |
| du -d 1 -h | folder size | |
| youtube-dl -x --audio-format m4a --postprocessor-args "-ss 00:00:02.00 -t 00:09:27.00" https://www.youtube.com/watch?v=AETFvQonfV8 | download audio from youtube | |
| git log -L 5,15:<file> | |
| git blame <file> -L 5,15 | |
| git blame <file> -L :'string' | |
| git blame -C | follow code movement in commit. In multiple or all commits |

# TODO
[Space Age seD - batch edit](https://github.com/ms-jpq/sad)

# vim
TODO: [vimgrep](http://vimcasts.org/episodes/search-multiple-files-with-vimgrep/), [comment](https://github.com/tomtom/tcomment_vim), [yoink](https://github.com/svermeulen/vim-yoink), [subversive](https://github.com/svermeulen/vim-subversive), [cutlass](https://github.com/svermeulen/vim-cutlass)
TODO: [vim-visual-multiline](https://github.com/mg979/vim-visual-multi)
[vim docs](https://vimdoc.sourceforge.net/htmldoc/help.html), [vim cast](http://vimcasts.org/episodes/page/8/)
[1](https://www.maketecheasier.com/cheatsheet/vim-keyboard-shortcuts/), [2](https://blog.codepen.io/2014/02/21/vim-key-bindings/)
| CMD | Action |
|-----| --- |
| `q:` | command history |
| `@:`| repeat command|
| `.` | repeat action|
| `;` | repeat f, t forward. `,` repeats backwards |
| `&` | repeat last `:s`. `g&` remembers flag
| `:g/^$/d` | Delete every line that matches empty regex |
| `C-Z` | Suspend vim and return to terminal. `fg` | 
| `C-d` | Auto-complete command on `:` |
| `C-f` | Search history |
| `C-g` | Relative file path |
| `1C-g` | Absolute file path |
| `C-v$A`| append at end of lines |
| `:1,3 mo 5`| Move lines 1 to 3 to after 5|
| `:1,3 co 5`| Copy lines 1 to 3 to after 5|
| `:1,3 d`| Delete lines 1 to 3|
| `:1,3 m$`| Move lines 1 to 3 to end of file|
| `:!` | cli |

| CMD | Action |
|-----| --- |
| `+` |  start of next line|
| `-` |  end of next line|
| `)` |  next .|
| `b/e` | start/end of word |
| `w` | next word |
| `50%` | Move to middle of file |
| `6fc` | Forward to 6tj `c` |
| `6w` | Forward 6 words |
| `6b` | Backward 6 words |
| `6tc` | Place cursor the left of 6th c from cursor. `T` backwards |
| `gM` | Middle of line |
| `gm` | Middle of line width |
| `gk` | Move up displayed line |
| `gj` | Move down displayed line |
| `\``\` | Double \` goes back to last position used on a go |
| `gg/G` | Top/Bottom of file |
| `H/L/M` | Top/Middle/Bottom of screen. Prepending causes that action on selection till +-3 lines |
| `zt/z/b` | Top/middle/bottom of screen |
| `z.` | Center line and move cursor to first char of line |
| `z-` | Move last line to bottom |
| `z<CR>` | Center line |

| CMD | Action |
|-----| --- |
| `~` |  flip case of character. `g~[motion]` |
| `u/U` | Lower/Uppercase in visual. `gu/U`. Undo one/all changes in normal |
| `gugu` | Line is lower case |
| `g?[motion]` | Rot13 |

| CMD | Action |
|-----| --- |
| `C-a` | add 1|
| `C-x` | subtract 1|
| `gC-a` | `:h v_g_CTRL-A`. Order list |
| `dC-X/A` | Change timestamp to current time (local/UTC) |
| `gx` | Open url in browser |
| `gd/D` | Goto local/global definition. See ctags for stronger gd |
| `gg=G` | Goto first line, indent till G |

Insert mode
| CMD | Action |
|-----| --- |
| `C-o` | Run one command in normal mode (from insert mode) |
| `C-w` | Delete word to left |
| `C-h` | Backspace |
| `C-j` | newline |
| `C-d/t` | Un/indent |

Wincmd
| CMD | Action |
|-----| --- |
| `n C-w C-w` | Move to nth window. Topleft to bottomright |
| `C-w s/v` | Split horizontally/vertically |
| `C-w c/o` | Close/Other windows |
| `C-w =` | Equalize windows |
| `C-w nx` | Swap with nth windows, without cursor |
| `C-w w/W` | Move to next/previous window |
| `C-w R` | Rotate windows (down, right) |
| `C-w r` | Rotate windows (up, left) |
| `C-w H/J/K/L` | Move window to far left, down, up, right (can expand to full length) |
| `C-w h/j/k/l` | Move focus to window to left, down, up, right |
| `C-w h/j/k/l` | # TODO: Move window to left, down, up, right |

| CMD | Action |
|-----| --- |
| word | Delimited by configurable characters |
| WORD | Delimited by whitespace |
| `aw` | a word |
| `iw` | inner word (retains whitespace or character) |
| `as` | a sentence |
| `ap` | a paragraph |
| `a"` | a string |
| `a(` | a () |
| ` ab` | a block |
| `a<` | a \<\> |

Most delete sequences overwrite `""`. Paste with `"0p`
| CMD | Action |
|-----| --- |
| `dt/f<char>` | Delete till/including next char. T/F is backwards |
| `d0` | Delete till start of line |
| `dw` | Delete word till next delimiter |
| `dW` | Delete till next whitespace |
| `db` | Delete word till previous delimiter |
| `dB` | Delete till previous whitespace |
| `dd` | Delete whole line |
| `S` | Delete whole line and insert mode. `cc` |
| `D` | Delete till end of line. `d$` |
| `C` | Change till end of line. `c$` |
| `d|` | Delete till start of line |
| `dG` | Delete till end of file |
| `dgg` | Delete till start of file |
| `daw` | Delete a word |
| `das` | Delete a sentence |
| `dap` | Delete a paragraph |
| `dab/B` | Delete a ()/{} |
| `da"` | Delete a string |
| `da(` | Delete a () |
| `dVa(` | Delete full block |
| `dva(` | Delete inside () |
| `dab` | Delete a block |
| `ci/a<enclosure>` | Delete everything inside/including enclosure and go to insert |
| `vi/a<enclosure>` | Select everything inside/including enclosure |

| CMD | Action |
|-----| --- |
| `//?` | Search forward/backward |
| `<C-o/i>` | Go back/forward. Tracks cursor |
| `*/#` | Next/previous occurance of word under cursor |
| `R` | Replace mode |
| `:s/f/r` | replace first f with r in current line |
| `:s/f/r/g` | replace all f with r in current line |
| `:s/f/r/gi` | case-insensitive |
| `:3,10s/f/r/g` | replace in inclusive range 3 to 10 |
| `:.,+4s/f/r/g` | replace in current till next 4 lines. `.`: current line, `$`: previous line |
| `:%s/f/r/g` | replace all f with r in file |
| `:%s/f/r/gc` | confirm each substitution. `a`: all remaining, `l`: replace and quit, `^E`, `^Y`: scroll |
| `:s/\<f\>/r/` | match `f` as whole word, not substring |
| `:%s/^f*/r/gc` | regex `f*` |
| `:s|f|r|` | Use `|` (or other non-alphanumeric single byte character) if `/` is in search pattern |
| `:s` | substitute command history |
| `:5,20s/^/#/` | Add `#` at start of lines (comment) |
| `:5,20s/^#//` | Delete `#` (uncomment) |
| `:%s/apple\|orange\|mango/fruit/g` | replace all 3 with fruit |
| `:%s/\s\+$//e` | remove trailing whitespace at end all lines |
| `%Subvert/facilit{y,ies}/building{,s}/g` | Substitute `:S` |

| CMD | Action |
|-----| --- |
| `:r <file>` | Read file into current buffer |
| `:r !<cmd>` | Read output of command into current buffer (under cursor) |
| `:r !<cmd> | grep <pattern> | awk '{print $2}' | sort -u` | Read output of command into current buffer |
| `:tabnew <file>` | Open file in new tab |
| `:e <file>` | Open file in same buffer |
| `:e!` | Reload file |
| `:e#` | Go back to previous file |
| `:e %:h` | Go back to directory of current file |
| `:e %:p` | Go back to full path of current file |
| `:e %:p:h` | Go back to parent directory of current file |
| `:w <file>` | Write file. Visual mode writes selected lines. |

| CMD | Action |
|-----| --- |
| `yiw` | copy current word. `viw` selects word under cursor |
| `ciw` | cut current word and move to insert|
| `"ay{motion}` | yank to `a` |
| `C-r"` | paste " buffer (in insert mode)|
| `"0p` | paste yanked buffer |
| `"*y` | Copy to clipboard, `"*p` |
| `:%y+` | Copy all lines |
| `vggy` | Copy till top |
| `yt,` | Copy till `,` |
| `yi(` | Copy inside `()` |

| CMD | Action |
|-----| --- |
| `zj/k` | Next/previous fold |
| `[/]z` | Move to open/close of fold |
| `za` | Toggle fold |
| `zA` | Toggle fold recursively. `O` for all folds at cursor |
| `zo/c` | Open/Close fold |
| `zm/r` | Increase/Decrease fold level by one |
| `zR/M` | Open/Close all folds |
| `zd/E` | Delete fold/all folds |
| `zf#j` | Create fold from cursor to # lines down |
| `zf ` | Create empty fold |
| `:AnyFoldActivate` | Activate fold |
| `<leader>fw` | Word under cursor |
| `<leader>ft` | Toggle |
| `<leader>fs` | Previous search pattern |
| `<leader>fS` | Lines containing spelling errors |
| `<leader>fi/d` | Increase/decreases lines around context |
| `<leader>fe` | Set modified fold values to original and end search |
| `<leader>fp` | Foldsearch on regex |

| CMD | Action |
|-----| --- |
| `<C-W>p` | Move to previous window |
| `<C-w><arrow key>` | Move in window in direction |
| `gt` | Forward tab |
| `gT` | Backward tab |
| `:bw` | buffer wipeout |
| `:b n` | Go to buffer |
| `:b <Tab>` | Use tab to cycle through buffers |
| `:e#` | Previous buffer, `:b#` |
| `tabe#` | Open last buffer in new tab |
| `:e#n` | Go back n buffers |
| `:sp` | Split horizontally |
| `:vsp` | Split vertically. `<C-w>v` |

# Nerdtree-V
| CMD | Action |
|-----| --- |
| `i` | horizontal split |
| `s` | vertical split |
| `m` | mv |
| `c` | cp |
| `d` | rm |
Plug 'preservim/nerdtree'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ryanoasis/vim-devicons'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'PhilRunninger/nerdtree-buffer-ops'

Plug 'PhilRunninger/nerdtree-visual-selection'


# Unimpaired
| CMD | Action |
|-----|--------|
| `[/]<space>` | Add newlines before/after cursor line |
| `[/]e` | Swap cursor line up/down |
| `[/]f` | Next/previous file in directory |
| `[/]n` | Next/previous SCM markers |
| `>/=/<p` | Paste after line, increasing/reindenting/decreasing indent. `P` Paste up |

# Fugitive
| CMD | Action |
|-----| --- |
| `:Gremove` | `:Git rm %` |
| `:Gmove <path>` | `:Git mv % <path>` |
| `:Gwrite` | `:Git add %` |
| `:Gread` | `:Git checkout %` |
| `:Gclog` | git log |
| `:Gclog --grep=<regex> --` | Search commit message |
| `:Gclog -S<regex>` | Search in delta of every commit |

# Fugitive diff
| CMD | Action |
|-----| --- |
| `:Gvdiffsplit!` | 3 way merge |
| `:diffget //2` | keep target (left) |
| `:diffget //3` | keep merge (right) |
| `:diffupdate` | sync diff highlight (use |) |
| `:Gwq` | Write to git and exit diff |
| `[c` | go to previous conflict |
| `]c` | go to next conflict |
| `<C-W><C-O>` | `:only` Close all windows except current (exit diff) |
| `dp` | Put buffer and diffupdate, `:Gwrite` exits diff and stages file |
| `:Gwrite!` | selects buffer |
| `do/p` | `:diffget/put` in 2 way split |

# Fugitive edit
| CMD | Action |
|-----| --- |
| `:Gedit <branch>:<file>` | Open file in ReadOnly buffer |
| `:Gedit <sha>` | Explore git history |
| `a` | show sha |
| `:edit %:h` | go back, `e#` |
| <C-^> | exit gedit |
| `C` | reutrn to commit object |
| `:Gsplit <branch>:%` | Open same file in <branch> |
| `:Gedit` | go back to working tree |
| `:Gbrowse` | open in GH |
| `:'<,'>Gbrowse` | Highlight lines |
| `d3o` | https://github.com/tpope/vim-fugitive/issues/1313#issuecomment-523632340 |

# GitGutter
| CMD | Action |
|-----|--------|
| `:GitGutterLineHighlightsToggle` | Show inline diff |
| `:GitGutterBufferToggle` | Disable in buffer |
| `]/[c` | Jump to next/previous hunk |
| `<Leader>hs/u` | Stage/Unstage hunk |
| `x,yGitGutterStageHunk` | stage x,y or visually select lines to stage part of a hunk |
| `<Leader>hp` | Preview hunk |
| TODO: `command! Gqf GitGutterQuickFix | copen` | Load hunks into quickfix |
| `:GitGutterAll` | Update gutter |
| `:GitGutterFold` | Fold unchanged lines | 

# QuickFix
| CMD | Action |
|-----|--------|
| `:copen` | Show quickfix list |
| `:cnext` | Next fix |
| `:cprevious` | Previous fix |
| `:next` | |
| `:bprevious` | |

# CtrlP
| CMD | Action |
|-----| --- |
| <C-z> | Mark files |
| <C-x> | Horizontal split |
| <C-o> | Vertical split |
| <C-t> | Open in tab |
| <C-f> | Cycle mode forward |
| <C-b> | Cycle mode backward |
| <C-d> | Toggle filepath and name |
| <C-r> | Toggle regex |
| <C-p> | Search history. `n` is forward |
| <C-y> | Create file/directories |
| `:CtrlPClearCache` | Rescan fs or F5 |

# Surround
Opening enclosure adds whitespace
| CMD | Action |
|-----|--------|
| `cs<1><2>` | Switch enclosure 1 with 2 |
| `cst<2>` | When enclosure 1 is a tag |
| `ds<1>` | Remove enclosure entirely |
| `ysiw<1>` | Enclose word |
| `cs4w<1>` | Enclose 4 words |
| `yss<1>` | Wrap line |
| `v/VS` | Visual mode enclose |
| `ysiwffoo` | Create function foo |

# Abolish - Coercion
| CMD | Action |
|-----|--------|
| `crs` | snake_case |
| `crm` | MixedCase |
| `crc` | camelCase |
| `cru` | UPPER_CASE |
| `cr-` | dash-case |
| `cr.` | dot.case |

# bash math
| CMD | Output | Comments |
|-----|--------| -------- |
| `echo $(2 + 3)` | 5 | |
| `expr 2 + 3` | 5 | |
| `awk 'BEGIN { x = 2; y = 3; print "x + y = "(x+y) }'` | x + y = 5 | awk substitution, float |
| `echo "2+3" \| bc` | 5 | **B**asic **C**alculator, -l for float |
| `echo "2 3 + p" \| dc` | 5 | **D**esk **C**alculator, p: print, precision calculator |
| `declare -i x=2 y=3 z=x+y` | | Declare `x=2, y=3` and `z=x+y` |
| `factor 100 | 100: 2 2 5 5` | |
| `let x=2+3 | echo $x` | 5 | substitution |
| `test 2 -gt 3; echo $?` | 1 | evaluate conditionals |
| `[ 2 -gt 3 ]; echo $?` | 1 | evaluate in math context |
| `printf %.2f "$((10**3 * 1/3))e-3"` | 0.33 | printf %.<precision>f "$((10**<multiplier> * <fraction>))e-<multiplier>" | precision |
| `echo $((2#1010+2#1010))` | 20 | base2 |
| `echo $((010+010))` | 16 | base8: 0 prefix |
| `echo $((0xA+0xA))` | 20 | base16: 0x prefix |

# python

`df[col] = df[col].str.replace(r'\d+', '', regex=True)`     string manipulation
`re.split('\d+', s) split on regex
Retain delimitors after split: https://stackoverflow.com/a/2136580/12555857 (wrap regex in capture group `()`)

# tealdeer
Generate default config file `~/.config/tealdeer/config.toml` with `tldr --seed-config`.


cat > .curlrc <<EOF
-w "\n"
silent
-D /dev/stderr
EOF
