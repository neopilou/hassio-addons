#!/usr/bin/with-contenv bashio

echo "[Info] Starting Tvheadend docker!"

streamlink https://www.youtube.com/watch?v=DTTKcCK9rM8

tvheadend -C

echo "[Info] End !"
