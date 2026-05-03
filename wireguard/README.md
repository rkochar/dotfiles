# VPN

```bash
# [wireguard]: Warning <file> is world accessible.
chmod 600 <conf>

# Unexpected redirect (<<< is not in sh)
/bin/bash wg-up.sh
```


The wireguard conf file should look like
```conf
[Interface]
PrivateKey = 
Address = 
DNS = 

PostUp = /etc/wireguard/wireguard-ssh-routing.sh up
PostDown = /etc/wireguard/wireguard-ssh-routing.sh down

[Peer]
PublicKey = 
AllowedIPs = 
Endpoint = 
PresharedKey = 
```
