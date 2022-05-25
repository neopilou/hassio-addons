#!/usr/bin/with-contenv bashio

readonly ADDONS=/addons/TVHeadEnd

if ! bashio::fs.directory_exists "$ADDONS"; then
    mkdir "$ADDONS"
fi

echo "[Info] Starting Tvheadend docker!"

tvheadend -C -c /data

echo "[Info] End !"
