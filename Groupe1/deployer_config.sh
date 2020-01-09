#!/bin/sh
# construction des images à partir des dockerfiles
#docker build . -t image_vierge
#docker build ../DockerFiles/apache_n7 -t image_web
#docker build ../DockerFiles/DHCP_n7 -t image_dhcp
#docker build ../DockerFiles/DNS_n7 -t image_dns
#docker build ../DockerFiles/FTP_n7 -t image_ftp
#docker build ../DockerFiles/quagga_n7 -t image_routeur

# dockerfiles pairés avec les scripts d'adressage IP
docker build ./dockerfiles/R1AS -t image_routeur_r1as

docker build ./dockerfiles/R2 -t image_routeur_r2
docker build ./dockerfiles/R2EN -t image_routeur_r2en
docker build ./dockerfiles/R2EX -t image_routeur_r2ex

# Routeurs entreprise
docker network create --driver=bridge r_en

# Routeurs entreprise
docker network create --driver=bridge r_as

# Connexion des routeurs
docker run -itd --name R1AS --cap-add=NET_ADMIN --network r_as image_routeur_r1as

docker run -itd --name R2 --cap-add=NET_ADMIN --network r_en image_routeur_r2
docker network connect r_as R2

docker run -itd --name R2EX --cap-add=NET_ADMIN --network r_en image_routeur_r2ex
docker run -itd --name R2EN --cap-add=NET_ADMIN --network r_en image_routeur_r2en

docker exec R1AS /home/start.sh
docker exec R2 /home/start.sh
docker exec R2EX /home/start.sh
docker exec R2EN /home/start.sh

# Serveur web
# docker run --name serveur_web --network reseau_int -p 8080:80 image_web
