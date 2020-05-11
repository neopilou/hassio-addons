#!/bin/bash

echo "[Info] Starting Router UPnP Bandwidth docker!"

CONFIG_PATH=/data/options.json

mqtt_protocol=$(jq --raw-output ".mqtt_protocol" $CONFIG_PATH)
mqtt_server=$(jq --raw-output ".mqtt_server" $CONFIG_PATH)
mqtt_port=$(jq --raw-output ".mqtt_port" $CONFIG_PATH)
topic=$(jq --raw-output ".topic" $CONFIG_PATH)
mqtt_username=$(jq --raw-output ".mqtt_username" $CONFIG_PATH)
mqtt_password=$(jq --raw-output ".mqtt_password" $CONFIG_PATH)
router_url=$(jq --raw-output ".router_url" $CONFIG_PATH)
	
mqtt_url="$mqtt_protocol://$mqtt_server:$mqtt_port"
	
go get -u -v github.com/huin/goupnp
go get -u -v github.com/eclipse/paho.mqtt.golang
go get -u -v github.com/gorilla/websocket
go get -u -v golang.org/x/net/proxy
	
go run rub.go -router $router_url -user $mqtt_username -password $mqtt_password -broker $mqtt_url -topic $topic