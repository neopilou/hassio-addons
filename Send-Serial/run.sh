#!/bin/bash

echo "[Info] Starting Send-Serial docker!"

CONFIG_PATH=/data/options.json

port=$(jq --raw-output ".port" $CONFIG_PATH)

ls /dev/

stty -F /dev/ttyUSB0 38400 cread clocal cs8

echo "[Info] Listening for messages via stdin service call..."

while read -r msg; do
    cmd="$(echo "$msg" | jq --raw-output '.command')"
    	
	echo "[Info] Send to Serial"
	echo -n -e $cmd > $port  				
	echo "[Info] Sended to Serial"
	echo ""
	echo "[Info] Listening for messages via stdin service call..."
	
done
