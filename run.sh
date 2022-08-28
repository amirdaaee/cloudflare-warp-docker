#!/bin/bash

warp-svc > /var/log/warp/log &
(
	while ! warp-cli --accept-tos register; do
	sleep 1
	>&2 echo "Awaiting warp-svc become online..."
done
warp-cli --accept-tos set-mode proxy
warp-cli --accept-tos set-proxy-port 40000
warp-cli --accept-tos connect
) && \
/usr/bin/v2ray -config /etc/v2ray/v2f-config.json