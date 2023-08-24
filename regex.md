# List of Useful Commands and Regex

docker image rmi $(docker image ls | tail -n+2 | awk '$1 ~ "ghcr" {print $3}')
unique file extensions `find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u`
grep -x # Keep these
grep -v # Remove these
kafkacat -b <kafka-service>:<port> -L

base64 encode `echo -n "" | base64` (or not)

# vim
`@:` repeat command
`.`  repeat action

`+`   start of next line
`-`   end of next line
`)`   next .

`~`   flip case of character 
`C-a` add 1
`C-x` subtract 1

`#` search current word (like `?`)

`:1,3 mo 5` Move lines 1 to 3 to after 5

`ciw` cut current word and move to insert
`C-R"` paste " buffer (in insert mode)

# pandas

`df[col] = df[col].str.replace(r'\d+', '', regex=True)`     string manipulation
