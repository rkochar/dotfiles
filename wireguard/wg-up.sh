#!/bin/bash
set -euo pipefail

WG_DIR="/etc/wireguard/conf"

# Grab all .conf files dynamically
LS_OUT=$(sudo ls ${WG_DIR} 2>/dev/null | grep conf)
echo $LS_OUT
readarray -t CONFIGS <<< "$LS_OUT"

# Make sure we actually found something
if [ ${#CONFIGS[@]} -eq 0 ]; then logger "No WireGuard config files found in ${WG_DIR}. Exiting."
    exit 1
fi

# Pick one at random
RANDOM_CONFIG=${CONFIGS[$RANDOM % ${#CONFIGS[@]}]}
# Tear down any existing connections
logger "Verifying cleanup"
for CFG in "${CONFIGS[@]}";
do
    wg-quick down "${WG_DIR}/${CFG}" >/dev/null 2>&1 || true
done

# Bring up the lucky winner
logger "Starting WireGuard with config: ${RANDOM_CONFIG}"
wg-quick up "${WG_DIR}/${RANDOM_CONFIG}"
