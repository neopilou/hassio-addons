#!/bin/bash

echo "[Info] Starting FTP Backup docker!"

CONFIG_PATH=/data/options.json

ftpprotocol=$(jq --raw-output ".ftpprotocol" $CONFIG_PATH)
ftpserver=$(jq --raw-output ".ftpserver" $CONFIG_PATH)
ftpport=$(jq --raw-output ".ftpport" $CONFIG_PATH)
ftpbackupfolder=$(jq --raw-output ".ftpbackupfolder" $CONFIG_PATH)
ftpusername=$(jq --raw-output ".ftpusername" $CONFIG_PATH)
ftppassword=$(jq --raw-output ".ftppassword" $CONFIG_PATH)
addftpflags=$(jq --raw-output ".addftpflags" $CONFIG_PATH)
KEEP_LAST=$(jq --raw-output ".keep_last // empty" $CONFIG_PATH)

if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="/"
fi

ftpurl="$ftpprotocol://$ftpserver:$ftpport/$ftpbackupfolder/"
credentials=""
if [ "${#ftppassword}" -gt "0" ]; then
	credentials="-u $ftpusername:$ftppassword"
fi
	
hassbackup="/backup"
tarpath="$hassbackup/*.tar"

while read -r msg; do
    # parse JSON
    echo "$msg"
    cmd="$(echo "$msg" | jq --raw-output '.command')"
    echo "[Info] Received message with command ${cmd}"
    if [[ $cmd = "upload" ]]; then
		echo "[Info] trying to upload $tarpath to $ftpurl"
		curl $addftpflags $credentials -T $tarpath $ftpurl
		echo "[Info] Finished ftp backup"
	fi
	if [[ "$KEEP_LAST" ]]; then
		echo "[Info] keep_last option is set, cleaning up files..."
		python3 /keep_last.py "$KEEP_LAST"
	fi
done