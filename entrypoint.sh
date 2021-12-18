#!/bin/bash

(
while ! warp-cli --accept-tos register; do
	sleep 1
	>&2 echo "Awaiting warp-svc become online..."
done
warp-cli --accept-tos set-mode proxy
warp-cli --accept-tos set-proxy-port 40000
warp-cli --accept-tos connect
iptables -t nat -A PREROUTING -p tcp --dport 40000 -j DNAT --to-destination 127.0.0.1
iptables -t nat -A PREROUTING -p udp --dport 40000 -j DNAT --to-destination 127.0.0.1
) &

exec warp-svc
