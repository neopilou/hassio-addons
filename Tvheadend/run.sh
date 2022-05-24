#!/usr/bin/with-contenv bashio

readonly SHARE=/addons/TVHeadEnd

if ! bashio::fs.directory_exists "$ADDONS"; then
    mkdir "$ADDONS"
fi

echo "[Info] Starting Tvheadend docker!"

streamlink https://www.youtube.com/watch?v=DTTKcCK9rM8

tvheadend -C -c /data

echo "[Info] End !"
