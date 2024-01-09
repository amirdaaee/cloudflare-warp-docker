
# Cloudflare WARP Docker

This repository contains a Dockerized version of [Cloudflare WARP](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/), allowing users to run Cloudflare's WARP service within a Docker container as socks and http proxy.

## Usage

To use this Docker image, follow these steps:
1. Clone the repository:
  ```bash
  git clone https://github.com/amirdaaee/cloudflare-warp-docker.git
  ```
2. Build the Docker image:
  ```bash
  docker build -t cloudflare-warp .
  ```
3.Run the Docker container:
  ```bash
  docker run -d --name warp -p 127.0.0.1:8080:8080 -p 127.0.0.1:1080:1080 cloudflare-warp:latest
  ```
now 127.0.0.1:1080 can be used as socks proxy and 127.0.0.1:8080 can be used as http proxy

> For your convenience, you can choose to use the pre-built Docker image available on [Docker Hub](https://hub.docker.com/r/amirdaaee/cloudflare-warp) or you can use [docker-compose](https://github.com/amirdaaee/cloudflare-warp-docker/blob/master/docker-compose.yml)

## Configuration
The following environment variables can be used to configure the WARP client:
- LICENSE_KEY[*optional*]: Your WARP client license key

## Disclaimer

It's important to note that this repository is not affiliated with Cloudflare, and the use of Cloudflare's WARP service is subject to Cloudflare's terms of service. For more information about Cloudflare WARP, please refer to the official Cloudflare documentation.
