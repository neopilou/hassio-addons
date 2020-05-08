#!/bin/bash

echo "[Info] Starting Netgear Sensors docker!"

CONFIG_PATH=/data/options.json

mosquitto_server=$(jq --raw-output ".mosquitto_server" $CONFIG_PATH)
mosquitto_port=$(jq --raw-output ".mosquitto_port" $CONFIG_PATH)
topic=$(jq --raw-output ".topic" $CONFIG_PATH)
mosquitto_username=$(jq --raw-output ".mosquitto_username" $CONFIG_PATH)
mosquitto_password=$(jq --raw-output ".mosquitto_password" $CONFIG_PATH)
netgear_url=$(jq --raw-output ".netgear_url" $CONFIG_PATH)
netgear_username=$(jq --raw-output ".netgear_username" $CONFIG_PATH)
netgear_password=$(jq --raw-output ".netgear_password" $CONFIG_PATH)
refresh_interval=$(jq --raw-output ".refresh_interval" $CONFIG_PATH)

ng_credentials="-u $netgear_username:$netgear_password"

echo "[Info] Starting uploading txbs and rxbs every $refresh_interval seconds"

ng_url="http://$netgear_url/RST_statistic.htm"

while true; do

	#curl $ng_credentials -s $ng_url
	
	ng_data="$(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm')" #| /bin/sed -n 's/var wan_txbs="\(.*\)";/\1/p') * 8 / 1000
	#rxbs="$(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm')" #| /bin/sed -n 's/var wan_rxbs="\(.*\)";/\1/p') * 8 / 1000
	
	echo "$ng_data"
	
	sedtxbs=$(sed -n 's/var wan_txbs="\(.*\)";/\1/p' < $ng_data)
	sedrxbs=$(sed -n 's/var wan_rxbs="\(.*\)";/\1/p' < $ng_data)
	
	echo "$sedtxbs"
	
	python3 /pub.py -u $mosquitto_server -p $mosquitto_port -l $mosquitto_username -m $mosquitto_password -o $topic -t $sedtxbs -r $sedrxbs
	
	sleep $refresh_interval
	
done
