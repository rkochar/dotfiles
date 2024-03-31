| ping raspberrypi.local |  |
| nmap -sn 192.168.1.0/24 | Scan network |
| sudo ssh rkochar@192.168.1.19 |

https://www.raspberrypi.com/documentation/computers/remote-access.html
https://pimylifeup.com/raspberry-pi-ssh-keys/


```
Host wrecker
    User wreckerpi
    Hostname wrecker.local
    IdentityFile ~/.ssh/wreckerpi_id_rsa

Host smasher
    User smasherpi
    Hostname smasher.local #42.duckdns.org #smasher.local
    IdentityFile ~/.ssh/smasherpi_id_rsa
```
