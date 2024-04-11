#!/bin/bash

source $(dirname $0)/.env

CURRENT_IP=$(curl -s http://checkip.amazonaws.com/)
REGISTERED_IP=$(nslookup $HOSTNAME | awk '/^Address: / { print $2 }')

if [ "$CURRENT_IP" != "$REGISTERED_IP" ]; then
    echo "IP changed update to $CURRENT_IP"
    curl -k -u "$NOIP_USER:$(echo $NOIP_PASSWORD | base64 -d)" "https://dynupdate.no-ip.com/nic/update?hostname=$HOSTNAME&myip=$CURRENT_IP"
else
    echo "NO IP changes"
fi