# docker-warp-proxy

Docker image to run **cloudflare-warp** in proxy mode

## Usage

```
docker run -d --name warp -p 127.0.0.1:8080:8080 -p 127.0.0.1:1080:1080 --restart unless-stopped amirdaaee/cloudflare-warp:latest
```
or you can use [docker-compose](https://github.com/amirdaaee/cloudflare-warp-docker/blob/master/docker-compose.yml)

now 127.0.0.1:1080 can be used as socks proxy and 127.0.0.1:8080 can be used as http proxy
