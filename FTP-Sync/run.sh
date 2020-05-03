#!/bin/bash

echo "[Info] Starting FTP Backup docker!"

CONFIG_PATH=/data/options.json

protocol=$(jq --raw-output ".protocol" $CONFIG_PATH)
server=$(jq --raw-output ".server" $CONFIG_PATH)
port=$(jq --raw-output ".port" $CONFIG_PATH)
path=$(jq --raw-output ".path" $CONFIG_PATH)
username=$(jq --raw-output ".username" $CONFIG_PATH)
password=$(jq --raw-output ".password" $CONFIG_PATH)
KEEP_LAST=$(jq --raw-output ".keep_last // empty" $CONFIG_PATH)

if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="/"
fi

ftpurl="$protocol://$server:$port/$path/"

credentials=""
if [ "${#password}" -gt "0" ]; then
	credentials="-u $username:$password"
fi
	
backuppath="/backup/"

echo "[Info] Listening for messages via stdin service call..."

while read -r msg; do
    # parse JSON
    echo "$msg"
    cmd="$(echo "$msg" | jq --raw-output '.command')"
    echo "[Info] Received message with command ${cmd}"
    if [[ $cmd = "upload" ]]; then
		echo "[Info] trying to upload $tarpath to $ftpurl"
		for f in /backup./*.tar; do
			curl $credentials -T $f $ftpurl
		done
		echo "[Info] Finished ftp backup"
	fi
	if [[ "$KEEP_LAST" ]]; then
		echo "[Info] keep_last option is set, cleaning up files..."
		python3 /keep_last.py "$KEEP_LAST"
	fi
done
