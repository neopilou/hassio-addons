#!/bin/bash

echo "[Info] Starting Tvheadend docker!"

find / -name tvheadend

/usr/bin/tvheadend -C -d -s

while true
done

echo "[Info] End !"
