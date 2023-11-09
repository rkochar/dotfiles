# List of Useful Commands and Regex
| Tool | CMD | Action |
|-----|---|---|
|docker| docker image rmi $(docker image ls \| tail -n+2 | awk '$1 ~ "ghcr" {print $3}') | cleanup images |
| kubectl | kubectl get service -o=custom-columns=NAME:metadata.name,NAMESPACE:metadata.namespace | Get n,ns of svc |
|bash| unique file extensions `find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`| unique file extensions in a directory |
|docker|docker search --filter is-official=true busybox | search officual busybox images |
|grep| grep -x | Keep these|
|grep| grep -v | Remove these|
|kafka | kafkacat -b <kafka-service>:<port> -L | debug kafka connection |
| exa | ls -s time | sort newest at bottom |
| exa | ls -s newest --reverse | sort newest at top |
| awk | awk 'BEGIN{FS=","}{sum+=$2}END{print sum}' <file> | sum second column of csv ", " |
| vim | :verbose set timeout? timeoutlen? ttimeout? ttimeoutlen? | |
base64 encode `echo -n "" | base64` (or not)

# vim
TODO: [vimgrep](http://vimcasts.org/episodes/search-multiple-files-with-vimgrep/), [comment](https://github.com/tomtom/tcomment_vim), [yoink](https://github.com/svermeulen/vim-yoink), [subversive](https://github.com/svermeulen/vim-subversive), [cutlass](https://github.com/svermeulen/vim-cutlass)
[vim docs](https://vimdoc.sourceforge.net/htmldoc/help.html), [vim cast](http://vimcasts.org/episodes/page/8/)
[1](https://www.maketecheasier.com/cheatsheet/vim-keyboard-shortcuts/), [2](https://blog.codepen.io/2014/02/21/vim-key-bindings/)
| CMD | Action |
|-----| --- |
| `q:` | command history |
| `@:`| repeat command|
| `.` | repeat action|
| `C-d` | Auto-complete command on `:` |
| `C-g` | Relative file path |
| `1C-g` | Absolute file path |
| `C-v$A`| append at end of lines |
| `:1,3 mo 5`| Move lines 1 to 3 to after 5|

| CMD | Action |
|-----| --- |
| `+` |  start of next line|
| `-` |  end of next line|
| `)` |  next .|
| `50%` | Move to middle of file |
| `2fc` | Forward to 2nd `c` |
| `6w` | Forward 6 words |
| `6b` | Backward 6 words |
| `zz` | Center line |
| `z.` | Center line and move cursor to first char of line |
| `zt` | Move line to top |
| `zb` | Move line to bottom |
| `z-` | Move last line to bottom |
| `gM` | Middle of line |
| `gm` | Middle of line width |
| `gk` | Move up displayed line |
| `gj` | Move down displayed line |
| `\``\` | Double \` goes back to last position used on a go |

| CMD | Action |
|-----| --- |
|`~` |  flip case of character |
|`C-a` | add 1|
|`C-x` | subtract 1|

| CMD | Action |
|-----| --- |
| `dw` | Delete word till next delimiter |
| `dW` | Delete till next whitespace |
| `db` | Delete word till previous delimiter |
| `dB` | Delete till previous whitespace |

| CMD | Action |
|-----| --- |
| `#` | search current word (like `?`, `*`) |
| `:s/f/r/` | replace first f with r in current line |
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

| CMD | Action |
|-----| --- |
| `ciw` | cut current word and move to insert|
| `C-R"` | paste " buffer (in insert mode)|
| `"0p` | paste yanked buffer |
| `:%y+` | Copy all lines |

| CMD | Action |
|-----| --- |
| `<C-W>p` | Move to previous window |
| `<C-w><arrow key>` | Move in window in direction |
| `gt` | Forward tab |
| `gT` | Backward tab |
| `:bw` | buffer wipeout |
| `:b n` | Go to buffer |
| `:b <Tab>` | Use tab to cycle through buffers |
| `:e#` | Previous buffer |
| `:e#n` | Go back n buffers |

# Nerdtree-V
| CMD | Action |
|-----| --- |
| `i` | horizontal split |
| `s` | vertical split |
| `m` | mv |
| `c` | cp |
| `d` | rm |

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
| `:Gdiff` | 3 way merge |
| `:diffget //2` | keep target (left) |
| `:diffget //3` | keep merge (right) |
| `:diffupdate` | sync diff highlight (use |) |
| `[c` | go to previous conflict |
| `]c` | go to next conflict |
| `<C-W><C-O>` | `:only` |
| `:only` | Close all windows except current (exit diff) |
| `dp` | Select other buffer, `:Gwrite` exits |
| `:Gwrite!` | selects buffer |

# Fugitive diff
| CMD | Action |
|-----| --- |
| `:Gedit <branch>:<file>` | Open file in ReadOnly buffer |
| `:Gedit <sha>` | Explore git history |
| `a` | show sha |
| `:edit %:h` | go back |
| `C` | reutrn to commit object |
| `:Gedit` | go back to working tree |
| `:Gbrowse` | open in GH |
| `:'<,'>Gbrowse` | Highlight lines |

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

# bash math
| CMD | Output | Comments |
|-----|--------| -------- |
| `echo $((2 + 3))` | 5 | |
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


cat > .curlrc <<EOF
-w "\n"
silent
-D /dev/stderr
EOF
