# List of Useful Commands and Regex

docker image rmi $(docker image ls | tail -n+2 | awk '$1 ~ "ghcr" {print $3}')
