# docker-warp-proxy

Docker image to run **cloudflare-warp** in proxy mode

## Usage

```
docker run -d --name warp -p 127.0.0.1:40000:40000 --cap-add NET_ADMIN --sysctl net.ipv4.conf.eth0.route_localnet=1 --restart unless-stopped amirdaaee/warp-proxy:latest
```
or you can use [docker-compose](https://github.com/amirdaaee/docker-cloudflare-warp/blob/master/docker-compose.yml)

now 127.0.0.1:4000 can be used as both http and socks proxy