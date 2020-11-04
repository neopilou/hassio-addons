#!/bin/bash

echo "[Info] Starting Netgear Sensors docker!"

echo "[Info] Starting uploading txbs and rxbs every $refresh_interval seconds"

txbs1=""
rxbs1=""

txbs2=""
rxbs2=""

txbs=""
rxbs=""

while true; do
	
	txbs= txbs2 - txbs1
	rxbs= rxbs2 - rxbs1	
	
done
