# List of Useful Commands and Regex

| Tool | CMD | Action |
|-----|---|---|
|docker| docker image rmi $(docker image ls \| tail -n+2 | awk '$1 ~ "ghcr" {print $3}') | cleanup images |
|bash| unique file extensions `find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`| unique file extensions in a directory |
|docker|docker search --filter is-official=true busybox | search officual busybox images |
|grep| grep -x | Keep these|
|grep| grep -v | Remove these|
|kafka | kafkacat -b <kafka-service>:<port> -L | debug kafka connection |

base64 encode `echo -n "" | base64` (or not)

# vim
| CMD | Action |
|-----| --- |
|`@:`| repeat command|
|`.` | repeat action|
|`C-v$A`| append at end of lines |

| CMD | Action |
|-----| --- |
|`+` |  start of next line|
|`-` |  end of next line|
|`)` |  next .|

| CMD | Action |
|-----| --- |
|`~` |  flip case of character |
|`C-a` | add 1|
|`C-x` | subtract 1|

| CMD | Action |
|-----| --- |
|`#` | search current word (like `?`)|

| CMD | Action |
|-----| --- |
|`:1,3 mo 5`| Move lines 1 to 3 to after 5|

| CMD | Action |
|-----| --- |
|`ciw` | cut current word and move to insert|
|`C-R"`|  paste " buffer (in insert mode)|

# bash math
| CMD | Output | Comments |
|-----|--------| -------- |
| `echo $((2 + 3))` | 5 | |
| expr 2 + 3 | 5 | |
| awk 'BEGIN { x = 2; y = 3; print "x + y = "(x+y) }' | x + y = 5 | awk substitution, float |
| echo "2+3" \| bc | 5 | **B**asic **C**alculator, -l for float |
| echo "2 3 + p" \| dc | 5 | **D**esk **C**alculator, p: print, precision calculator |
| declare -i x=2 y=3 z=x+y | | Declare `x=2, y=3` and `z=x+y` |
| factor 100 | 100: 2 2 5 5 | |
| let x=2+3 | echo $x | 5 | substitution |
| test 2 -gt 3; echo $? | 1 | evaluate conditionals |
| [ 2 -gt 3 ]; echo $? | 1 | evaluate in math context |
| printf %.2f "$((10**3 * 1/3))e-3" | 0.33 | printf %.<precision>f "$((10**<multiplier> * <fraction>))e-<multiplier>" | precision |
| echo $((2#1010+2#1010)) | 20 | base2 |
| echo $((010+010)) | 16 | base8: 0 prefix |
| echo $((0xA+0xA)) | 20 | base16: 0x prefix |

# pandas

`df[col] = df[col].str.replace(r'\d+', '', regex=True)`     string manipulation
