# List of Useful Commands and Regex

docker image rmi $(docker image ls | tail -n+2 | awk '$1 ~ "ghcr" {print $3}')
unique file extensions find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u
grep -x # Keep these
grep -v # Remove these

# vim
`@:` repeat command
`.`  repeat action

`+`   start of next line
`-`   end of next line
`)`   next .

`~`   flip case of character 
`C-a` add 1
`C-x` subtract 1
