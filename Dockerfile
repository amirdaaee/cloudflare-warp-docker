FROM docker.io/debian:buster-slim AS v2fly
WORKDIR /v2fly
COPY v2fly-docker/v2ray.sh /root/v2ray.sh
RUN set -x && \
	apt update && \
	apt install -y tzdata openssl ca-certificates wget unzip && \
	mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray && \
	chmod +x /root/v2ray.sh && \
	/root/v2ray.sh "linux/amd64" "v4.45.2"

FROM docker.io/debian:buster-slim AS cf
ARG VERSION
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /
COPY pubkey.gpg /
RUN set -x && \
	apt update && \
	apt install -y gnupg ca-certificates libcap2-bin curl && \
	apt-key add /pubkey.gpg && \
	echo "deb http://pkg.cloudflareclient.com/ buster main" > /etc/apt/sources.list.d/cloudflare-client.list && \
	apt update && \
	apt install cloudflare-warp=$VERSION -y && \
	apt autoremove -y && \
	apt clean -y &&\
	rm -rf /var/lib/apt/lists/*

FROM cf AS cf2fly
ENV DEBIAN_FRONTEND noninteractive
ARG VERSION
LABEL \ 
	org.opencontainers.image.authors="Amir Daaee <amir.daaee@gmail.com>" \
	org.opencontainers.image.warp-version=$VERSION

COPY  run.sh /
COPY --from=v2fly /usr/bin/v2ray /usr/bin/v2ctl /usr/bin/
COPY --from=v2fly /usr/local/share/v2ray/geosite.dat /usr/local/share/v2ray/geoip.dat /usr/local/share/v2ray/
COPY v2f-config.json /etc/v2ray/
RUN chmod +x /run.sh && \
	mkdir -p /var/log/warp
CMD [ "/run.sh" ]
