#!/bin/bash

echo "[Info] Starting Tvheadend docker!"

find / -name tvheadend

/usr/bin/tvheadend -C -d -s

while true
  do echo "[Info] Executing"
done

echo "[Info] End !"
