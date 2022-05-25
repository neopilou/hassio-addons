#!/usr/bin/with-contenv bashio

readonly ADDONS=/addons/TVHeadEnd

if ! bashio::fs.directory_exists "$ADDONS"; then
    mkdir "$ADDONS"
fi

echo "[Info] Starting Tvheadend docker!"

ffmpeg -loglevel fatal -i "rtsp://mafreebox.freebox.fr/fbxtv_pub/stream?namespace=1&service=294&flavour=hd" -vcodec copy -acodec copy -f mpegts -tune zerolatency pipe:1

tvheadend -C -c /data

echo "[Info] End !"
