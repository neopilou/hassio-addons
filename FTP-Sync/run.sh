#!/bin/bash

echo "[Info] Starting FTP Backup docker!"

CONFIG_PATH=/data/options.json

protocol=$(jq --raw-output ".ftpprotocol" $CONFIG_PATH)
server=$(jq --raw-output ".ftpserver" $CONFIG_PATH)
port=$(jq --raw-output ".ftpport" $CONFIG_PATH)
path=$(jq --raw-output ".ftpbackupfolder" $CONFIG_PATH)
username=$(jq --raw-output ".ftpusername" $CONFIG_PATH)
password=$(jq --raw-output ".ftppassword" $CONFIG_PATH)
KEEP_LAST=$(jq --raw-output ".keep_last // empty" $CONFIG_PATH)

if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="/"
fi

ftpurl="$protocol://$server:$port/$path/"

credentials=""
if [ "${#ftppassword}" -gt "0" ]; then
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
		curl $credentials -T $backuppath $ftpurl
		echo "[Info] Finished ftp backup"
	fi
	if [[ "$KEEP_LAST" ]]; then
		echo "[Info] keep_last option is set, cleaning up files..."
		python3 /keep_last.py "$KEEP_LAST"
	fi
done
