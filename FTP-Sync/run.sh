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

echo "[Info] Listening for messages via stdin service call..."

while read -r msg; do
	# parse JSON
	echo "$msg"
        cmd="$(echo "$msg" | jq --raw-output '.command')"
    	
    	if [[ $cmd = "upload" ]]; then
		echo "[Info] Starting ftp sync"
                cd /backup
		
		for f in *.tar; do
			ftpfile="$protocol://$server:$port/$path/$f"
			if ( wget -S --spider --user=$username --password=$password $ftpfile 2>&1 | grep '213' ); then
				echo "[Info] File $f already exist on $ftpurl"
			else
				echo "[Info] Uploading $f to $ftpurl"
				curl $credentials -sT $f $ftpurl
			fi
		done
		
		if [[ "$KEEP_LAST" ]]; then
			echo "[Info] keep_last option is set, cleaning up files..."
			python3 /keep_last.py "$KEEP_LAST"
		fi
		
		echo "[Info] Finished ftp sync"
		echo ""
		echo "[Info] Listening for messages via stdin service call..."
	fi
	
done
