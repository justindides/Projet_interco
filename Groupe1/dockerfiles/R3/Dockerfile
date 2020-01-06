FROM debian:jessie-slim
RUN apt-get update
RUN apt-get -y install iptables apt-utils iproute2 net-tools systemd telnet nano iputils-ping tcpdump inetutils-traceroute quagga
RUN apt-get -f install
COPY  ./quagga /etc/quagga
COPY ./adr_r3.sh ~/adr_r3.sh
RUN mkdir /etc/scripts
ENV PATH "/etc/scripts:$PATH"
ENTRYPOINT ~/adr_r3.sh && /etc/init.d/quagga start && /bin/bash
