#!/bin/bash

echo "[Info] Starting Netgear Sensors docker!"

CONFIG_PATH=/data/options.json

mqtt_server=$(jq --raw-output ".mqtt_server" $CONFIG_PATH)
mqtt_port=$(jq --raw-output ".mqtt_port" $CONFIG_PATH)
topic=$(jq --raw-output ".topic" $CONFIG_PATH)
mqtt_username=$(jq --raw-output ".mqtt_username" $CONFIG_PATH)
mqtt_password=$(jq --raw-output ".mqtt_password" $CONFIG_PATH)
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
	
	python3 /pub.py -u $mqtt_server -p $mqtt_port -l $mqtt_username -m $mqtt_password -o $topic -t $sedtxbs -r $sedrxbs
	
	sleep $refresh_interval
	
done
