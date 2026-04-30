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
 
# scp
```
scp -i ~/.ssh/smasherpi_id_rsa ~/Downloads/*.conf <user>@<ip-address>:<path in pi>
```

# vpn
[nmcli wireguard](https://neilzone.co.uk/2025/12/bringing-up-a-wireguard-tunnel-automatically-on-boot-using-nmcli/)
```bash
nmcli connection show
nmcli connection modify NAME connection.autoconnect yes
```
