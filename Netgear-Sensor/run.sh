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

ng_credentials="--user $netgear_username:$netgear_password"

echo "[Info] Starting uploading txbs and rxbs every $refresh_interval seconds"

txbs1=""
rxbs1=""

txbs2=""
rxbs2=""

txbs=""
rxbs=""

topic_txbs="$topic/txbs"
topic_rxbs="$topic/rxbs"

while true; do
	
	txbs1= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | /bin/sed -n 's/var wan_txbs="\(.*\)";/\1/p') * 8 / 1000
	rxbs1= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | /bin/sed -n 's/var wan_rxbs="\(.*\)";/\1/p') * 8 / 1000
	
	txbs2= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | /bin/sed -n 's/var wan_txbs="\(.*\)";/\1/p') * 8 / 1000
	rxbs2= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | /bin/sed -n 's/var wan_rxbs="\(.*\)";/\1/p') * 8 / 1000
	
	txbs= txbs2 - txbs1
	rxbs= rxbs2 - rxbs1	
	
done
