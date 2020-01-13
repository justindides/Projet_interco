FROM debian:jessie-slim
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute isc-dhcp-server
RUN apt-get -f install
EXPOSE 8000 67 80
COPY start.sh /home/
RUN ["chmod", "+x", "/home/start.sh"]
ENTRYPOINT ./bin/bash
