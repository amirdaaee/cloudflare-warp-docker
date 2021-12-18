FROM docker.io/debian:buster-slim

ARG VERSION

LABEL \ 
	org.opencontainers.image.authors="Amir Daaee <amir.daaee@gmail.com>" \
	version=$VERSION


ENV DEBIAN_FRONTEND noninteractive
COPY pubkey.gpg entrypoint.sh /
RUN true && \
	apt update && \
	apt install -y gnupg ca-certificates libcap2-bin iptables && \
	apt-key add /pubkey.gpg && \
	echo "deb http://pkg.cloudflareclient.com/ buster main" > /etc/apt/sources.list.d/cloudflare-client.list && \
	apt update && \
	apt install cloudflare-warp=$VERSION -y && \
	apt purge ca-certificates -y && \
	apt autoremove -y && \
	apt clean -y && \
	chmod +x /entrypoint.sh
EXPOSE 40000/tcp
EXPOSE 40000/udp
ENTRYPOINT [ "/entrypoint.sh" ]
