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

txbsA=""
rxbsA=""

txbsB=""
rxbsB=""

txbs=""
rxbs=""

topic_txbs="$topic/txbs"
topic_rxbs="$topic/rxbs"

echo "[Info] MQTT Server : $mqtt_server"
echo "[Info] MQTT Port : $mqtt_port"
echo "[Info] Topic: $topic"
echo "[Info] MQTT Username : $mqtt_username"
echo "[Info] MQQT Password : $mqtt_password"
echo "[Info] Netgear URL : $netgear_url"
echo "[Info] Netgear Username : $netgear_username"
echo "[Info] Netgear Password : $netgear_password"

echo "[Info] Starting uploading txbs and rxbs every $refresh_interval seconds"

while true; do
	
	txbsA= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | sed -n 's/var wan_txbs="\(.*\)";/\1/p')
	rxbsA= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | sed -n 's/var wan_txbs="\(.*\)";/\1/p')
	
	echo "[Info] $(/bin/curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm')"
	echo "[Info] $(curl -s 'http://$netgear_username:$netgear_password@$netgear_url/RST_statistic.htm')"
	echo "[Info] $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | sed -n 's/var wan_txbs="\(.*\)";/\1/p')"
	
	echo "[Info] txbsA = $txbsA"
	echo "[Info] rxbsA = $rxbsA"
	
	sleep 1
	
	txbsB= $(/bin/curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | /bin/sed -n 's/var wan_txbs="\(.*\)";/\1/p')
	rxbsB= $(curl $ng_credentials -s 'http://$netgear_url/RST_statistic.htm' | sed -n 's/var wan_txbs="\(.*\)";/\1/p')
	
	echo "[Info] txbsB = $txbsB"
	echo "[Info] rxbsB = $rxbsB"
	
	let txbs=txbsB-txbsA
	let rxbs=rxbsB-rxbsA
	
	let txbs=txbs*8/1000
	let rxbs=rxbs*8/1000
	
	echo "[Info] txbs = $txbs"
	echo "[Info] rxbs = $rxbs"
	
	/usr/bin/mosquitto_pub -h $mqtt_server -p $mqtt_port -u $mqtt_username -p $mqtt_password -t $topic_txbs -m "150"
	/usr/bin/mosquitto_pub -h $mqtt_server -p $mqtt_port -u $mqtt_username -p $mqtt_password -t $topic_rxbs -m $rxbs
		
	sleep 1
	
done
