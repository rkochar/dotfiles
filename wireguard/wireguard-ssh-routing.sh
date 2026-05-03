#!/bin/bash
set -e

TABLE="ssh"

get_lan() {
    ip route | awk '/^default/ && $5 !~ /^wg/ {print $5, $3}' | head -n1
}

read LAN_IF GW <<< "$(get_lan)"
echo "[LAN_IF]: ${LAN_IF}, [GW]: ${GW}"

case "$1" in
    up)
        # ip route add ${GW} dev ${LAN_IF}
	iptables -I INPUT -s ${GW} -j ACCEPT
	;;
    down)
        # ip route del ${GW} dev ${LAN_IF}
	iptables -D INPUT -s ${GW} -j ACCEPT
	;;
    *)
        echo "Unknown input: $@"
        exit 1
	;;
esac
