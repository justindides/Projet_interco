# Image de base
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    net-tools \
    vim \
    iputils-ping \
    python3 \
    quagga \
    isc-dhcp-server

COPY start.sh /home/
RUN ["chmod", "+x", "/home/start.sh"]

EXPOSE  8000
CMD ["python3", "-m", "http.server"]
ENTRYPOINT  /bin/bash
