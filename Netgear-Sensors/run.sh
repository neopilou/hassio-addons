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

ng_credentials="--user $netgear_username:$netgear_password"

echo "[Info] Starting uploading txbs and rxbs every $refresh_interval seconds"

txbs=""
rxbs=""

topic_txbs="$topic/txbs"
topic_rxbs="$topic/rxbs"

while true; do
	
	txbs= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm') #| /bin/sed -n 's/var wan_txbs="\(.*\)";/\1/p') * 8 / 1000
	rxbs= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm') #| /bin/sed -n 's/var wan_rxbs="\(.*\)";/\1/p') * 8 / 1000
	
	sedtxbs= $(sed -n 's/var wan_txbs="\(.*\)";/\1/p' < $txbs)
	
	mosquitto_pub -h $mosquitto_server -p $mosquitto_port -u $mosquitto_username -p $mosquitto_password -t $topic_txbs -m $txbs
	mosquitto_pub -h $mosquitto_server -p $mosquitto_port -u $mosquitto_username -p $mosquitto_password -t $topic_rxbs -m $rxbs
		
	sleep $refresh_interval
	
done
