FROM debian:jessie-slim
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute 
RUN apt-get -f install
COPY start.sh /home/
EXPOSE 8000 67 80
RUN ["chmod", "+x", "/home/start.sh"]
ENTRYPOINT ./home/start.sh && /bin/bash
